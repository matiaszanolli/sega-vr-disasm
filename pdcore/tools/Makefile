# pdcore profiling tools

CC = gcc
CFLAGS = -Wall -Wextra -O2 -I../include
LDFLAGS = -L../build -lpdcore

# For stub testing (no ROM needed)
STUB_SRC = ../test/picodrive_stubs.c

.PHONY: all clean test

all: profiler slave_diag

profiler: profiler.c $(STUB_SRC)
	@echo "==> Building profiler (with stubs for testing)"
	$(CC) $(CFLAGS) profiler.c $(STUB_SRC) -o profiler $(LDFLAGS)
	@echo "✓ Built: profiler"

slave_diag: slave_diag.c $(STUB_SRC)
	@echo "==> Building slave_diag (with stubs for testing)"
	$(CC) $(CFLAGS) slave_diag.c $(STUB_SRC) -o slave_diag $(LDFLAGS)
	@echo "✓ Built: slave_diag"

test: profiler
	@echo "==> Running profiler test (10 frames, stub mode)"
	LD_LIBRARY_PATH=../build ./profiler 10

test-slave: slave_diag
	@echo "==> Running slave diagnostic"
	LD_LIBRARY_PATH=../build ./slave_diag

clean:
	rm -f profiler slave_diag
	@echo "✓ Clean complete"
