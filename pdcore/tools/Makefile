# pdcore profiling tools

CC = gcc
CFLAGS = -Wall -Wextra -O2 -I../include
LDFLAGS = -L../build -lpdcore

# For stub testing (no ROM needed)
STUB_SRC = ../test/picodrive_stubs.c

.PHONY: all clean test

all: profiler

profiler: profiler.c $(STUB_SRC)
	@echo "==> Building profiler (with stubs for testing)"
	$(CC) $(CFLAGS) profiler.c $(STUB_SRC) -o profiler $(LDFLAGS)
	@echo "✓ Built: profiler"

test: profiler
	@echo "==> Running profiler test (10 frames, stub mode)"
	LD_LIBRARY_PATH=../build ./profiler 10

clean:
	rm -f profiler
	@echo "✓ Clean complete"
