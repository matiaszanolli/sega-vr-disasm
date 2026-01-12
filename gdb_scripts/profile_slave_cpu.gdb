target remote localhost:6871
set architecture sh2
# Watch COMM register writes (Master→Slave communication)
watch *(unsigned short*)0x20004020
commands
  silent
  printf "COMM0 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x20004020, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x20004022
commands
  silent
  printf "COMM1 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x20004022, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x20004024
commands
  silent
  printf "COMM2 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x20004024, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x20004026
commands
  silent
  printf "COMM3 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x20004026, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x20004028
commands
  silent
  printf "COMM4 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x20004028, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x2000402A
commands
  silent
  printf "COMM5 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x2000402A, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x2000402C
commands
  silent
  printf "COMM6 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x2000402C, $pc
  backtrace 3
  continue
end
watch *(unsigned short*)0x2000402E
commands
  silent
  printf "COMM7 changed to 0x%04X at PC=0x%08X\n", *(unsigned short*)0x2000402E, $pc
  backtrace 3
  continue
end
# To sample Slave CPU PC, press Ctrl+C periodically and check:
# info registers pc
# continue
continue
