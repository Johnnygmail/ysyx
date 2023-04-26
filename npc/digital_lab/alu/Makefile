TOPNAME = top
NXDC_FILES = constr/top.nxdc
INC_PATH ?=

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD  --build -cc  \
                                -O3 --x-assign fast --x-initial fast --noassert

BUILD_DIR = ./build
BUILD_SIM=./build_sim
OBJ_DIR = $(BUILD_DIR)/obj_dir
OBJ_DIR_SIM=$(BUILD_SIM)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
$(SRC_AUTO_BIND): $(NXDC_FILES)
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@
# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS += $(SRC_AUTO_BIND)
CSRC_SIM=$(shell find $(abspath ./csrc_sim) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
# rules for NVBoard
include $(NVBOARD_HOME)/scripts/nvboard.mk

# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
                --top-module $(TOPNAME) $^ \
                $(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
                --Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

all:default
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!
	$(VERILATOR) --cc --exe --trace --build \
		--top-module $(TOPNAME) $(VSRCS) $(CSRC_SIM)
	make -C obj_dir -f Vtop.mk Vtop
	./obj_dir/Vtop
	gtkwave wave.vcd
	@echo "Write this Makefile by your self."
run: $(BIN)
	@$^
#include ../Makefile
