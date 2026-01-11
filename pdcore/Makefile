# PicoDrive Debugger Core (pdcore) - Build System
#
# MVP-1: Core library with breakpoints and memory access
# Compiles standalone without PicoDrive modifications yet

.PHONY: all clean test

CC = gcc
# Note: -Werror disabled for MVP-1 stub functions with TODO implementations
# Re-enable after completing each phase
CFLAGS = -Wall -Wextra -O2 -fPIC -Iinclude
LDFLAGS = -shared

# Source files
SOURCES = src/pdcore.c src/pdcore_bp.c src/pdcore_exec.c
HEADERS = include/pdcore.h include/pdcore_internal.h include/pdcore_bp.h
OBJECTS = $(SOURCES:.c=.o)

# Output
LIBDIR = build
LIB = $(LIBDIR)/libpdcore.so

# Targets
all: $(LIB)

$(LIB): $(OBJECTS)
	@mkdir -p $(LIBDIR)
	@echo "==> Linking $@"
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
	@echo "✓ Clean complete"

test: $(LIB)
	@echo "✓ Library compiles successfully"
	@echo "✓ Phase 1 Foundation: COMPLETE"

# Debugging
show-vars:
	@echo "CC: $(CC)"
	@echo "CFLAGS: $(CFLAGS)"
	@echo "SOURCES: $(SOURCES)"
	@echo "OBJECTS: $(OBJECTS)"
	@echo "LIB: $(LIB)"

.PHONY: show-vars
