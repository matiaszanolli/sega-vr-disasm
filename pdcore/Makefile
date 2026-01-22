# PicoDrive Debugger Core (pdcore) - Build System
#
# MVP-1: Core library with breakpoints and memory access
# Integrated with PicoDrive via pdcore_bridge

.PHONY: all clean test

CC = gcc
# Note: -Werror disabled for MVP-1 stub functions with TODO implementations
# Re-enable after completing each phase
CFLAGS = -Wall -Wextra -O2 -fPIC -Iinclude -I../third_party/picodrive
LDFLAGS = -shared

# Source files
SOURCES = src/pdcore.c src/pdcore_bp.c src/pdcore_exec.c
HEADERS = include/pdcore.h include/pdcore_internal.h include/pdcore_bp.h
OBJECTS = $(SOURCES:.c=.o)

# PicoDrive bridge object
PICO_BRIDGE = ../third_party/picodrive/pico/pdcore_bridge.o

# Output
LIBDIR = build
LIB = $(LIBDIR)/libpdcore.so

# Targets
all: $(LIB)

$(LIB): $(OBJECTS)
	@mkdir -p $(LIBDIR)
	@echo "==> Linking $@"
	@$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(PICO_BRIDGE) 2>/dev/null || \
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS)
	@echo "✓ Built: $@"
	@ls -lh $@

%.o: %.c $(HEADERS)
	@echo "==> Compiling $<"
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@echo "==> Cleaning"
	rm -f $(OBJECTS)
	rm -rf $(LIBDIR)
	@rm -f build/test_mvp1
	@echo "✓ Clean complete"

test: all
	@echo "==> Building test..."
	@$(CC) $(CFLAGS) -o build/test_mvp1 tests/test_mvp1.c tests/pdcore_bridge_stubs.c $(OBJECTS)
	@echo "==> Running test..."
	@./build/test_mvp1

# Debugging
show-vars:
	@echo "CC: $(CC)"
	@echo "CFLAGS: $(CFLAGS)"
	@echo "SOURCES: $(SOURCES)"
	@echo "OBJECTS: $(OBJECTS)"
	@echo "LIB: $(LIB)"

.PHONY: show-vars
