CONFIG = mcu.config
include ${CONFIG}

AVRDUDE = avrdude -c bin/$(PROJECT_NAME) -p $(MCU)
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE    = avr-size --format=avr --mcu=$(MCU)
CC      = avr-gcc
SRCS=$(wildcard src/*.c)

CFLAGS=-std=c11 -Wall -Werror -g -Os -mmcu=${MCU} -DF_CPU=${CLK} -I.

all: 
	[ -d foo ] || mkdir foo
	${CC} ${CFLAGS} -o bin/${PROJECT_NAME}.bin ${SRCS}
	${OBJCOPY} -j .text -j .data -O ihex bin/${PROJECT_NAME}.bin bin/${PROJECT_NAME}.hex
clean:
	rm -Rf bin/
	$(foreach dir, ,rm -f $(dir)/*.o;)
