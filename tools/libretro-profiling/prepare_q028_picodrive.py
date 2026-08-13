#!/usr/bin/env python3
"""Reproduce the Q-028 complete all-access observer overlay fail closed."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path


FILES = (
    "platform/libretro/libretro.c",
    "pico/32x/32x.c",
    "pico/32x/memory.c",
    "pico/32x/draw.c",
    "pico/32x/sh2soc.c",
    "cpu/sh2/sh2.c",
    "cpu/sh2/mame/sh2pico.c",
)

# Q-027 postimages plus the unchanged Q-027-era 32X/reset sources.  The
# implementation verifier pins these to concrete hashes before release.
PREIMAGE_SHA256 = {
    "platform/libretro/libretro.c":
        "334d1107f8ad5def3062a64f189f1df6918d2f6225ae337c6fafd789cdaa1376",
    "pico/32x/memory.c":
        "214bff20e1afa77a305ff3f3e054d50db4a4e2779ab625d0f41a72696249e48c",
    "pico/32x/draw.c":
        "b038807d5afc2a48a20e85f6579805e8d62e760085bb68e49414e1eb3d9a5b8f",
    "pico/32x/sh2soc.c":
        "5cb40756cfc89b34dfded7cc586dc3648007040c45446126395692f3895abb39",
    "cpu/sh2/mame/sh2pico.c":
        "5ffb2eed4c9d263bee8eae11fbf12bc277f85ff8b3948ca55e3ba68d22b340ef",
    "pico/32x/32x.c":
        "42eb3c1506f64510e8aab56d2f345ac5c190eddcb7e5697cfe8f6d53284d9eef",
    "cpu/sh2/sh2.c":
        "84ab47db5b2964ed6942805b701477f783d49c459766186228a819554da891db",
}

SOURCE_SHA256 = {
    "platform/libretro/libretro.c":
        "1398fe4464c711bf3338adab609134a1c7302d637311e34c263709c3758da8dd",
    "pico/32x/32x.c":
        "5e1d824ed49145eef28763cdb2cfae18c6976771a2b5c3fc3c826612254c92cd",
    "pico/32x/memory.c":
        "41337596d16b77effa21669117a93e6a12296fccef498109f4a0f1d78a4ba7d0",
    "pico/32x/draw.c":
        "6ad6b82e28897304088c4bfa7f8998b5c88b8158034b208df8054c76722a3703",
    "pico/32x/sh2soc.c":
        "f461b52a745e27094ce2c7dbfd9f18f3bf13de811b06b055dc2d25c71d4beed2",
    "cpu/sh2/sh2.c":
        "e1823750b95cf5243e198f193c5be0e2a4d517e33ab8c5eb3c312b300191df74",
    "cpu/sh2/mame/sh2pico.c":
        "8536800f11a167039f9c460ecd0b4d1bb4403ecc35b31270827abbe2627ea91e",
}
OBSERVER_SHA256 = \
    "cefe3abc8151fbdf5d5a9f5ab89a098360ac79a34c900e401a34bb73c43f0398"


def sha256_path(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def replace_exact(source: str, old: str, new: str, label: str,
                  count: int = 1) -> str:
    old_count, new_count = source.count(old), source.count(new)
    if old_count == count and new_count == 0:
        return source.replace(old, new, count)
    if old_count == 0 and new_count == count:
        return source
    raise ValueError(
        f"Q-028 overlay precondition {label}: old_count={old_count} "
        f"new_count={new_count} expected={count}"
    )


def transform_libretro(path: Path, include_path: Path) -> None:
    source = path.read_text()
    if sha256_path(include_path) != OBSERVER_SHA256:
        raise ValueError("Q-028 observer include identity mismatch")
    source = replace_exact(source,
        'extern void Pico32xVrdMmioTraceMasterUninstall(void);\n',
        'extern void Pico32xVrdMmioTraceMasterUninstall(void);\n\n'
        '#include "q028_all_access_observer.inc"\n', "observer-include")
    source = replace_exact(source,
        "static void vrd_instruction_start(unsigned int pc)\n{\n",
        "static void vrd_instruction_start(unsigned int pc)\n{\n"
        "    vrd_q028_m68k_instruction(pc);\n", "m68k-fetch-hook")
    source = replace_exact(source,
        "        (!vrd_write_trace_log && !vrd_caller_trace_log &&\n"
        "         !vrd_mmio_trace_log))\n",
        "        (!vrd_write_trace_log && !vrd_caller_trace_log &&\n"
        "         !vrd_mmio_trace_log && !vrd_q028_log))\n",
        "instruction-hook-policy")
    source = replace_exact(source,
        "    if (vrd_mmio_trace_log)\n"
        "        vrd_mmio_trace_pc = pc;\n",
        "    if (vrd_mmio_trace_log || vrd_q028_log)\n"
        "        vrd_mmio_trace_pc = pc;\n", "m68k-data-pc")
    source = replace_exact(source,
        "   }\n\n   strncpy(pico_overlay_path, content_path, sizeof(pico_overlay_path)-4);",
        "   }\n\n   vrd_q028_m68k_install();\n\n"
        "   strncpy(pico_overlay_path, content_path, sizeof(pico_overlay_path)-4);",
        "m68k-install")
    source = replace_exact(source,
        '   if (getenv("VRD_PROFILE_PC"))   /* VRD: SH2 interpreter required for PC sampling */\n',
        '   if (getenv("VRD_PROFILE_PC") || getenv("VRD_Q028_ACCESS_LOG"))\n',
        "force-interpreter")
    source = replace_exact(source,
        "   PicoFrame();\n", "   PicoFrame();\n   vrd_q028_capture_frame();\n",
        "raw-capture")
    source = replace_exact(source,
        "   video_cb((short *)buff, vout_width, vout_height, vout_width * 2);\n",
        "   vrd_q028_callback_dispatch((short *)buff, vout_width, "
        "vout_height, vout_width * 2);\n"
        "   video_cb((short *)buff, vout_width, vout_height, vout_width * 2);\n",
        "callback-dispatch")
    source = replace_exact(source,
        "void retro_init(void)\n{\n", "void retro_init(void)\n{\n"
        "   vrd_q028_early_init();\n", "early-init")
    source = replace_exact(source,
        '   if (vrd_caller_trace_log)\n'
        '      vrd_caller_trace_finish(0, vrd_profile_frame, "core_deinit");\n',
        '   if (vrd_caller_trace_log)\n'
        '      vrd_caller_trace_finish(0, vrd_profile_frame, "core_deinit");\n'
        '   vrd_q028_finish("core_deinit");\n', "finish")
    path.write_text(source)


def transform_draw(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source, '#include "../pico_int.h"\n',
        '#include "../pico_int.h"\n\n#ifdef __LIBRETRO__\n'
        'extern void vrd_q028_render_select(unsigned int fbctl, int offs,\n'
        '  int lines, int sync_line, int draw_mode, int skip_frame);\n#endif\n',
        "render-select-declaration")
    source = replace_exact(source,
        "  Pico.est.DrawLineDest = (char *)DrawLineDestBase32x + offs * DrawLineDestIncrement32x;\n"
        "  Pico.est.DrawLineDestIncr = DrawLineDestIncrement32x;\n"
        "  dram = Pico32xMem->dram[Pico32x.vdp_regs[0x0a/2] & P32XV_FS];\n",
        "  Pico.est.DrawLineDest = (char *)DrawLineDestBase32x + offs * DrawLineDestIncrement32x;\n"
        "  Pico.est.DrawLineDestIncr = DrawLineDestIncrement32x;\n"
        "#ifdef __LIBRETRO__\n"
        "  vrd_q028_render_select(Pico32x.vdp_regs[0x0a/2], offs, lines,\n"
        "    Pico32x.sync_line, Pico32xDrawMode, PicoIn.skipFrame);\n"
        "#endif\n"
        "  dram = Pico32xMem->dram[Pico32x.vdp_regs[0x0a/2] & P32XV_FS];\n",
        "render-select-anchor")
    path.write_text(source)


def transform_32x(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source, '#include "../pico_int.h"\n',
        '#include "../pico_int.h"\n\n#ifdef __LIBRETRO__\n'
        'extern void vrd_q028_idl_begin(unsigned int external_bios);\n'
        'extern void vrd_q028_idl_end(void);\n'
        'extern void vrd_q028_fs_preapply(const char *site,\n'
        '  unsigned int old_fbctl, unsigned int new_fs);\n#endif\n',
        "idl-declarations")
    source = replace_exact(source,
        "  sh2_peripheral_reset(&ssh2);\n\n"
        "  // if we don't have BIOS set, perform it's work here.",
        "  sh2_peripheral_reset(&ssh2);\n\n#ifdef __LIBRETRO__\n"
        "  vrd_q028_idl_begin(p32x_bios_m != NULL);\n#endif\n\n"
        "  // if we don't have BIOS set, perform it's work here.", "idl-begin")
    source = replace_exact(source,
        "    // program will set M_OK\n  }\n\n  // SSH2",
        "    // program will set M_OK\n  }\n#ifdef __LIBRETRO__\n"
        "  vrd_q028_idl_end();\n#endif\n\n  // SSH2", "idl-end")
    source = replace_exact(source,
        "    Pico32x.vdp_regs[0x0a/2] ^= P32XV_FS;\n"
        "    Pico32xSwapDRAM(Pico32x.pending_fb ^ P32XV_FS);",
        "#ifdef __LIBRETRO__\n"
        "    vrd_q028_fs_preapply(\"vblank\", Pico32x.vdp_regs[0x0a/2],\n"
        "      (Pico32x.pending_fb & P32XV_FS) != 0);\n"
        "#endif\n"
        "    Pico32x.vdp_regs[0x0a/2] ^= P32XV_FS;\n"
        "    Pico32xSwapDRAM(Pico32x.pending_fb ^ P32XV_FS);",
        "fs-vblank-preapply")
    path.write_text(source)


def transform_sh2_core(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source, '#include "compiler.h"\n',
        '#include "compiler.h"\n\n#ifdef __LIBRETRO__\n'
        'extern void vrd_q028_sh2_irq(SH2 *sh2, unsigned int entering);\n'
        '#endif\n', "irq-declaration")
    source = replace_exact(source, "void sh2_do_irq(SH2 *sh2, int level, int vector)\n{\n",
        "void sh2_do_irq(SH2 *sh2, int level, int vector)\n{\n"
        "#ifdef __LIBRETRO__\n\tvrd_q028_sh2_irq(sh2, 1);\n#endif\n",
        "irq-entry")
    path.write_text(source)


def transform_memory(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source, "DRC_DECLARE_SR;\n",
        "DRC_DECLARE_SR;\n\n#ifdef __LIBRETRO__\n"
        "extern void vrd_q028_fs_preapply(const char *site,\n"
        "  unsigned int old_fbctl, unsigned int new_fs);\n#endif\n",
        "fs-preapply-declaration")
    source = replace_exact(source,
        "static vrd_mmio_trace_master_observer_t *vrd_mmio_trace_master_observer;\n",
        "static vrd_mmio_trace_master_observer_t *vrd_mmio_trace_master_observer;\n"
        "extern void vrd_q028_sh2_access(SH2 *sh2, unsigned int address,\n"
        "  unsigned int value, unsigned int op, unsigned int width);\n"
        "extern void vrd_q028_memcpy_source(SH2 *sh2, unsigned int src,\n"
        "  unsigned int count, unsigned int size);\n",
        "memory-declarations")
    source = replace_exact(source,
        "        r[0x0a/2] ^= P32XV_FS;\n"
        "        Pico32xSwapDRAM(d ^ P32XV_FS);",
        "#ifdef __LIBRETRO__\n"
        "        vrd_q028_fs_preapply(\"blank\", r[0x0a/2],\n"
        "          (d & P32XV_FS) != 0);\n"
        "#endif\n"
        "        r[0x0a/2] ^= P32XV_FS;\n"
        "        Pico32xSwapDRAM(d ^ P32XV_FS);",
        "fs-blank-preapply")
    read_images = (
        ("    return *(s8 *)((p << 1) + MEM_BE2(a & sh2_map->mask));\n"
         "  else\n    return ((sh2_read_handler *)(p << 1))(a, sh2);\n",
         "    p = *(s8 *)((p << 1) + MEM_BE2(a & sh2_map->mask));\n"
         "  else\n    p = ((sh2_read_handler *)(p << 1))(a, sh2);\n"
         "#ifdef __LIBRETRO__\n  vrd_q028_sh2_access(sh2, a, p, 0, 1);\n#endif\n  return p;\n"),
        ("    return *(s16 *)((p << 1) + (a & sh2_map->mask));\n"
         "  else\n    return ((sh2_read_handler *)(p << 1))(a, sh2);\n",
         "    p = *(s16 *)((p << 1) + (a & sh2_map->mask));\n"
         "  else\n    p = ((sh2_read_handler *)(p << 1))(a, sh2);\n"
         "#ifdef __LIBRETRO__\n  vrd_q028_sh2_access(sh2, a, p, 0, 2);\n#endif\n  return p;\n"),
        ("    return CPU_BE2(*pd);\n  } else\n"
         "    return ((sh2_read_handler *)(p << 1))(a, sh2);\n",
         "    p = CPU_BE2(*pd);\n  } else\n"
         "    p = ((sh2_read_handler *)(p << 1))(a, sh2);\n"
         "#ifdef __LIBRETRO__\n  vrd_q028_sh2_access(sh2, a, p, 0, 4);\n#endif\n  return p;\n"),
    )
    for width, (old, new) in enumerate(read_images, 1):
        source = replace_exact(source, old, new, f"sh2-read-{width}")
    for bits, width in ((8, 1), (16, 2), (32, 4)):
        old = (f"void REGPARM(3) p32x_sh2_write{bits}(u32 a, u32 d, SH2 *sh2)\n"
               "{\n"
               f"  const void **sh2_wmap = sh2->write{bits}_tab;\n"
               "  sh2_write_handler *wh;\n\n"
               "  wh = sh2_wmap[SH2MAP_ADDR2OFFS_W(a)];\n"
               "  wh(a, d, sh2);\n}")
        new = old[:-2] + (f"\n#ifdef __LIBRETRO__\n"
               f"  vrd_q028_sh2_access(sh2, a, d, 1, {width});\n"
               "#endif\n}")
        source = replace_exact(source, old, new, f"sh2-write-{width}")
    source = replace_exact(source, "  len = count * size;\n",
        "  len = count * size;\n#ifdef __LIBRETRO__\n"
        "  /* Optimized source reads bypass the normal read callbacks. */\n"
        "  vrd_q028_memcpy_source(sh2, src, count, size);\n#endif\n",
        "optimized-memcpy")
    path.write_text(source)


def transform_interpreter(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source,
        '#include "../sh2.h"\n',
        '#include "../sh2.h"\n\n#ifdef __LIBRETRO__\n'
        "extern void vrd_q028_sh2_fetch_begin(SH2 *sh2, unsigned int address);\n"
        "extern void vrd_q028_sh2_fetch_end(SH2 *sh2, unsigned int address);\n"
        "extern void vrd_q028_sh2_instruction(SH2 *sh2, unsigned int pc,\n"
        "    unsigned int opcode);\n#endif\n", "interpreter-declarations")
    for address in ("sh2->delay", "sh2->pc"):
        old = f"\t\t\topcode = (UINT32)(UINT16)RW(sh2, {address});\n"
        new = ("#ifdef __LIBRETRO__\n"
               f"\t\t\tvrd_q028_sh2_fetch_begin(sh2, {address});\n#endif\n"
               f"\t\t\topcode = (UINT32)(UINT16)RW(sh2, {address});\n"
               "#ifdef __LIBRETRO__\n"
               f"\t\t\tvrd_q028_sh2_fetch_end(sh2, {address});\n#endif\n")
        source = replace_exact(source, old, new, f"fetch-{address}", 2)
    source = replace_exact(source,
        "\t\tsh2->delay = 0;\n\t\tsh2->pc += 2;\n",
        "#ifdef __LIBRETRO__\n\t\tvrd_q028_sh2_instruction(sh2, sh2->ppc, opcode);\n"
        "#endif\n\n\t\tsh2->delay = 0;\n\t\tsh2->pc += 2;\n",
        "instruction", 2)
    path.write_text(source)


def transform_sh2soc(path: Path) -> None:
    source = path.read_text()
    source = replace_exact(source,
        "DRC_DECLARE_SR;\n",
        "DRC_DECLARE_SR;\n\n#ifdef __LIBRETRO__\n"
        "extern unsigned int vrd_q028_bus_begin(unsigned int agent);\n"
        "extern void vrd_q028_bus_end(unsigned int previous);\n"
        "#define VRD_Q028_AGENT_M_DMAC0 2\n"
        "#define VRD_Q028_AGENT_M_DMAC1 3\n"
        "#define VRD_Q028_AGENT_S_DMAC0 4\n"
        "#define VRD_Q028_AGENT_S_DMAC1 5\n"
        "#define VRD_Q028_AGENT_M_DREQ0 6\n"
        "#define VRD_Q028_AGENT_S_DREQ0 7\n"
        "#define VRD_Q028_AGENT_M_DREQ1 8\n"
        "#define VRD_Q028_AGENT_S_DREQ1 9\n#endif\n",
        "bus-agent-declarations")
    source = replace_exact(source,
        "static void dmac_transfer_one(SH2 *sh2, struct dma_chan *chan)\n"
        "{\n  u32 size, d;\n",
        "static void dmac_transfer_one(SH2 *sh2, struct dma_chan *chan)\n"
        "{\n  u32 size, d;\n#ifdef __LIBRETRO__\n"
        "  struct dmac *dmac = (void *)&sh2->peri_regs[0x180 / 4];\n"
        "  unsigned int q028_previous = vrd_q028_bus_begin(sh2->is_slave ?\n"
        "    (chan == &dmac->chan[0] ? VRD_Q028_AGENT_S_DMAC0 : VRD_Q028_AGENT_S_DMAC1) :\n"
        "    (chan == &dmac->chan[0] ? VRD_Q028_AGENT_M_DMAC0 : VRD_Q028_AGENT_M_DMAC1));\n"
        "#endif\n", "single-dmac-begin")
    source = replace_exact(source,
        "    chan->tcr -= 4;\n    return;\n",
        "    chan->tcr -= 4;\n#ifdef __LIBRETRO__\n"
        "    vrd_q028_bus_end(q028_previous);\n#endif\n    return;\n",
        "single-dmac-mode3-end")
    source = replace_exact(source,
        "  if (chan->chcr & (1 << 12))\n    chan->sar += size;\n}\n",
        "  if (chan->chcr & (1 << 12))\n    chan->sar += size;\n"
        "#ifdef __LIBRETRO__\n  vrd_q028_bus_end(q028_previous);\n"
        "#endif\n}\n", "single-dmac-end")
    source = replace_exact(source,
        "  u32 size = (chan->chcr >> 10) & 3, up = chan->chcr & (1 << 14);\n"
        "  int count;\n",
        "  u32 size = (chan->chcr >> 10) & 3, up = chan->chcr & (1 << 14);\n"
        "  int count;\n#ifdef __LIBRETRO__\n"
        "  struct dmac *dmac = (void *)&sh2->peri_regs[0x180 / 4];\n"
        "  unsigned int q028_previous;\n#endif\n", "bulk-dmac-locals")
    source = replace_exact(source,
        "  // XXX check alignment of sar/dar, generating a bus error if unaligned?\n"
        "  count = p32x_sh2_memcpy(chan->dar, chan->sar, chan->tcr, 1 << size, sh2);\n",
        "  // XXX check alignment of sar/dar, generating a bus error if unaligned?\n"
        "#ifdef __LIBRETRO__\n"
        "  q028_previous = vrd_q028_bus_begin(sh2->is_slave ?\n"
        "    (chan == &dmac->chan[0] ? VRD_Q028_AGENT_S_DMAC0 : VRD_Q028_AGENT_S_DMAC1) :\n"
        "    (chan == &dmac->chan[0] ? VRD_Q028_AGENT_M_DMAC0 : VRD_Q028_AGENT_M_DMAC1));\n"
        "#endif\n"
        "  count = p32x_sh2_memcpy(chan->dar, chan->sar, chan->tcr, 1 << size, sh2);\n"
        "#ifdef __LIBRETRO__\n  vrd_q028_bus_end(q028_previous);\n#endif\n",
        "bulk-dmac-bracket")
    source = replace_exact(source,
        "  unsigned short dreqlen = Pico32x.regs[0x10 / 2];\n  int i;\n",
        "  unsigned short dreqlen = Pico32x.regs[0x10 / 2];\n  int i;\n"
        "#ifdef __LIBRETRO__\n"
        "  unsigned int q028_previous = vrd_q028_bus_begin(sh2->is_slave ?\n"
        "    VRD_Q028_AGENT_S_DREQ0 : VRD_Q028_AGENT_M_DREQ0);\n"
        "#endif\n", "dreq0-begin")
    source = replace_exact(source,
        "  else\n    sh2_end_run(sh2, 16);\n}\n\nstatic void dreq1_do",
        "  else\n    sh2_end_run(sh2, 16);\n#ifdef __LIBRETRO__\n"
        "  vrd_q028_bus_end(q028_previous);\n#endif\n}\n\nstatic void dreq1_do",
        "dreq0-end")
    source = replace_exact(source,
        "static void dreq1_do(SH2 *sh2, struct dma_chan *chan)\n{\n",
        "static void dreq1_do(SH2 *sh2, struct dma_chan *chan)\n{\n"
        "#ifdef __LIBRETRO__\n"
        "  unsigned int q028_previous = vrd_q028_bus_begin(sh2->is_slave ?\n"
        "    VRD_Q028_AGENT_S_DREQ1 : VRD_Q028_AGENT_M_DREQ1);\n"
        "#endif\n", "dreq1-begin")
    source = replace_exact(source,
        "  if (chan->tcr == 0)\n    dmac_transfer_complete(sh2, chan);\n}\n\nvoid p32x_dreq0_trigger",
        "  if (chan->tcr == 0)\n    dmac_transfer_complete(sh2, chan);\n"
        "#ifdef __LIBRETRO__\n  vrd_q028_bus_end(q028_previous);\n"
        "#endif\n}\n\nvoid p32x_dreq0_trigger",
        "dreq1-end")
    path.write_text(source)


def verify_sources(source_root: Path) -> bool:
    observer = source_root / "platform/libretro/q028_all_access_observer.inc"
    return (observer.is_file() and sha256_path(observer) == OBSERVER_SHA256 and
            all(SOURCE_SHA256[name] != "PENDING" and
                sha256_path(source_root / name) == SOURCE_SHA256[name]
                for name in FILES))


def prepare(source_root: Path, tool_root: Path) -> str:
    if sha256_path(tool_root / "q028_all_access_observer.inc") != \
            OBSERVER_SHA256:
        raise ValueError("Q-028 observer include identity mismatch")
    if verify_sources(source_root):
        return "already-applied"
    actual = {name: sha256_path(source_root / name) for name in FILES}
    if actual != PREIMAGE_SHA256:
        raise ValueError(f"Q-028 overlay preimage mismatch: {actual}")
    transform_libretro(source_root / FILES[0],
                       tool_root / "q028_all_access_observer.inc")
    generated_observer = source_root / "platform/libretro/q028_all_access_observer.inc"
    if generated_observer.exists():
        raise ValueError("Q-028 generated observer already exists in a preimage")
    generated_observer.write_bytes(
        (tool_root / "q028_all_access_observer.inc").read_bytes())
    transform_32x(source_root / FILES[1])
    transform_memory(source_root / FILES[2])
    transform_draw(source_root / FILES[3])
    transform_sh2soc(source_root / FILES[4])
    transform_sh2_core(source_root / FILES[5])
    transform_interpreter(source_root / FILES[6])
    actual = {name: sha256_path(source_root / name) for name in FILES}
    if any(value == "PENDING" for value in SOURCE_SHA256.values()):
        raise ValueError(f"Q-028 overlay postimages require pinning: {actual}")
    if actual != SOURCE_SHA256:
        raise ValueError(f"Q-028 overlay postimage mismatch: {actual}")
    return "applied"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, required=True)
    parser.add_argument("--tool-root", type=Path,
                        default=Path(__file__).resolve().parent)
    args = parser.parse_args()
    try:
        status = prepare(args.source_root.resolve(), args.tool_root.resolve())
    except (OSError, ValueError) as error:
        print(f"Q-028 PicoDrive preparation FAILED: {error}")
        return 1
    print(f"Q-028 PicoDrive all-access observer overlay: {status}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
