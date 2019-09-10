PREFIX ?= /usr/local
BIN_DIR = $(PREFIX)/bin
INCLUDE_DIR = $(PREFIX)/include
LIB_DIR = $(PREFIX)/lib

BIN = template
LIB = libctemplate.a
HEADER = ctemplate.h

CFLAGS = -I . -Wall -Os
LDFLAGS = -L .
LDLIBS = -lctemplate
ARFLAGS = -rcs

.PHONY: clean test style install uninstall

$(BIN): main.o $(LIB)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LDLIBS)

$(LIB): ctemplate.o
	$(AR) $(ARFLAGS) $@ $^

ctemplate.o: ctemplate.c ctemplate.h

main.o: main.c ctemplate.h

clean:
	rm -f *.o *.a template

test:
	cd t; ./test.sh

style:
	astyle -A3s4SpHk3jn *.c *.h examples/*.c

install: $(BIN)
	mkdir -p $(BIN_DIR)
	mkdir -p $(INCLUDE_DIR)
	mkdir -p $(LIB_DIR)
	install -m 755 $(BIN) $(BIN_DIR)/$(BIN)
	install -m 644 $(LIB) $(LIB_DIR)/$(LIB)
	install -m 644 $(HEADER) $(INCLUDE_DIR)/$(HEADER)

uninstall:
	rm -f $(BIN_DIR)/$(BIN)
	rm -f $(LIB_DIR)/$(LIB)
	rm -f $(INCLUDE_DIR)/$(HEADER)
