 
CC=gcc

MODELLIB=./sndpix.so
APPL=./viewer

PLI_INCLUDE=/home/lvd/modelsim/10.0b/modeltech/include

SRCLIB=./sndpix.c
SRCAPP=./viewer.c

all : $(APPL) $(MODELLIB) Makefile
#all : $(MODELLIB) Makefile

clean:
	rm $(APPL) $(MODELLIB)

$(MODELLIB) : $(SRCLIB) sndpix.h Makefile
	gcc -m32 -O2 -g -shared -Bsymbolic -fPIC -I$(PLI_INCLUDE) $(SRCLIB) -o $(MODELLIB)

$(APPL) : $(SRCAPP) Makefile
	gcc -O2 -g  $(SRCAPP) -o $(APPL) -lSDL

