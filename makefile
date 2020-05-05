## CONFIGURATION #############################################################

OUTPUT = Autonertia
CPU    = Cortex-M3
MCU    = TLE9879QXA40
OPT    = 2
LD_CMD = TLE9879.ld

## TOOLS #####################################################################

AS = $(TOOLDIR)/arm-none-eabi-as
CC = $(TOOLDIR)/arm-none-eabi-gcc
LD = $(TOOLDIR)/arm-none-eabi-ld
OC = $(TOOLDIR)/arm-none-eabi-objcopy

RM = rm -f
RD = rm -rf
MD = mkdir

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

## PATHS #####################################################################

PRJDIR = .
SRCDIR = App
LIBDIR = Libs
OBJDIR = Objects
LSTDIR = Listings
TOOLDIR = GCC/gcc-arm-none-eabi-9-2019-q4-major/bin

DIRS := $(LIBDIR)
DIRS += $(SRCDIR)

## FILES #####################################################################

OUT = $(OBJDIR)/$(OUTPUT)
ELF = $(OUT).elf
BIN = $(OUT).bin
HEX = $(OUT).hex
MAP = $(OUT).map

SRCS := $(call rwildcard, $(DIRS),*.s)
SRCS += $(call rwildcard, $(DIRS),*.c)
SRCS := $(filter %.s %.c, $(SRCS))

OBJS := $(notdir $(SRCS))
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.s=.o)
OBJS := $(patsubst %, $(OBJDIR)/%, $(OBJS))

ASMS := $(notdir $(SRCS))
ASMS := $(ASMS:.c=.s)
ASMS := $(patsubst %, $(LSTDIR)/%, $(ASMS))

ALLDIRS :=$(sort $(dir $(SRCS)))

INCS := $(patsubst %, -I$(PRJDIR)/ -I "%", $(ALLDIRS))

#VPATH needed, specifies a list of dirs that make should search
VPATH := $(ALLDIRS)

## OPTIONS ###################################################################

# flags common to compilers
FLAGS += -g
FLAGS += $(INCS)

# assembler flags
AFLAGS = $(FLAGS)
AFLAGS += --cpreproc

#c compiler flags
CFLAGS = $(FLAGS)
CFLAGS += -std=c99
CFLAGS += -D$(MCU)
CFLAGS += -O$(OPT)

# linker flags

## TARGETS ###################################################################

.PHONY: all build rebuild pre_build pre_compile dirs cleanall cleanversion elf_size

all: build

build: pre_build $(ELF) $(BIN) $(HEX) elf_size
	@echo "Finished build"

rebuild: cleanall build

# output to console
elf_size:
	@size $(ELF)
	@echo ""

pre_build:
	@echo "Building $(ELF)"
	@echo $(OBJS)

pre_compile: dirs
	@echo "Compiling"

$(ELF): pre_compile $(OBJS) 
	@echo "Linking"
	$(LD) $(LFLAGS) -Map=$(MAP) -T $(LD_CMD) -o $(ELF) $(OBJS)

$(BIN): $(ELF)
	@echo "Creating $(BIN) from $(ELF)"
	$(OC) -O binary $(ELF) $(BIN)

$(HEX): $(ELF)
	@echo "Creating $(HEX) from $(ELF)"
	$(OC) -O ihex $(ELF) $(HEX)

$(OBJDIR)/%.o: %.c
	@echo "$< -> $@"
	$(CC) -c $(CFLAGS) -o $@ $<

$(OBJDIR)/%.o: %.s
	@echo " $< -> $@"
	$(AS) $(AFLAGS) -o $@ $<

dirs: $(OBJDIR) $(LSTDIR)

$(OBJDIR):
	@echo "Making directory $(OBJDIR)"
	$(MD) $(OBJDIR)

$(LSTDIR):
	@echo "Making directory $(LSTDIR)"
	$(MD) $(LSTDIR)

cleanall:
	@echo "Cleanall"
	@echo "Removing Objects directory"
	$(RD) $(OBJDIR)
	@echo "Removing Listings directory"
	$(RD) $(LSTDIR)

clean:
	@echo "Clean"
	@echo "$(OBJDIR)/*.d"
	$(RM) $(OBJDIR)/*.d
	$(RM) $(OBJDIR)/*.elf
	$(RM) $(OBJDIR)/*.hex
	$(RM) $(OBJDIR)/*.bin
	$(RM) $(OBJDIR)/*.map
	@echo "$(OBJDIR)/*.o"
	$(RM) $(OBJDIR)/*.o
