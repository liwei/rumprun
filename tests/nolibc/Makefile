include ../../global.mk
include ${BUILDRUMP_TOOLFLAGS}

CFLAGS+=	${BUILDRUMP_TOOL_CFLAGS}

LDFLAGS:= -L$(abspath ../../rumprun/rumprun-${MACHINE_GNU_ARCH}/lib/rumprun-${PLATFORM})
LDFLAGS+= -L${RROBJ}/lib/libcompiler_rt

CPPFLAGS+= -I../../include -I../../rumprun/rumprun-${MACHINE_GNU_ARCH}/include
CPPFLAGS+= -I../../platform/${PLATFORM}/include

LDSCRIPT= ${RROBJ}/bmk.ldscript

LDFLAGS+= ${LDFLAGS.${MACHINE_GNU_ARCH}.${PLATFORM}}

OBJS= main.o ${RROBJ}/rumprun.o

.PHONY: clean

main.elf: ${OBJS}
	${CC} ${CFLAGS} ${LDFLAGS} -T${LDSCRIPT} 			\
	${OBJS} 							\
	-nostdlib							\
	-Wl,--whole-archive -lrumpvfs -lrump -Wl,--no-whole-archive	\
	-lcompiler_rt 							\
	-o $@

clean:
	rm -rf main.o main.elf
