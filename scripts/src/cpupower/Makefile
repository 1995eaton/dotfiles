CFLAGS=-std=gnu11 -c -Ofast -march=native
PREFIX=/usr/local
LDFLAGS=
SOURCES=main.c
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=cpupower

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@

install:
	install -m 0755 $(EXECUTABLE) $(PREFIX)/bin

uninstall:
	rm -f $(PREFIX)/bin/$(EXECUTABLE)

clean:
	rm *.o $(EXECUTABLE)
