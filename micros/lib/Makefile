TARGET=libgalileo2.a
SRCS=pputs.c pgets.c

FLAGS=-O2 -Wall -MMD
INCLUDE=-I.
LIBDIR=
LIBS=

CC=$(CROSS_COMPILE)gcc
CCAR=$(CROSS_COMPILE)ar
CFLAGS=$(FLAG) $(INCLUDE)
LDFLAGS=$(LIBDIR) $(LIBS)
CCARFLAGS=-crvs

all: $(TARGET)

$(TARGET): $(SRCS:.c=.o)
	$(CCAR) $(CCARFLAGS) $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

-include $(SCRS:.c=.d)

clean:
	rm -f *~ *.bak *.o *.d

distclean: clean
	rm -f $(TARGET)
