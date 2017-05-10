.PHONY: all
all: cmake

## versions

CMAKE_VER = 3.8.1
LLVM_VER = 3.9.1

## dirs

CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
BUILD = $(CWD)/build
TOOL = $(CWD)/tool
PFX = $(CWD)/mingw32

DIRS = $(GZ) $(SRC) $(BUILD) $(TOOL) $(PFX)

.PHONY: dirs
dirs:
	mkdir -p $(DIRS)

## tools required for build

CMAKE = cmake-$(CMAKE_VER)
CMAKE_GZ = $(CMAKE).tar.gz
CMAKE_URL = https://cmake.org/files/v3.8/$(CMAKE_GZ)

## packages

LLVM = llvm-$(LLVM_VER)
LLVM_GZ = $(LLVM).src.tar.xz
LLVM_URL = http://releases.llvm.org/$(LLVM_VER)/$(LLVM_GZ)

## download

WGET = wget -c --no-check-certificate -P $(GZ) 
.PHONY: gz
gz: $(GZ)/$(LLVM_GZ) $(GZ)/$(CMAKE_GZ)
$(GZ)/$(LLVM_GZ):
	$(WGET) $(LLVM_URL) && touch $@
$(GZ)/$(CMAKE_GZ):
	$(WGET) $(CMAKE_URL) && touch $@

## sources

.PHONY: src
src: $(SRC)/$(LLVM)/README

$(SRC)/%/README: $(GZ)/%.tar.gz
	cd src ; tar zx < $< && touch $@
$(SRC)/$(LLVM)/README.txt: $(GZ)/$(LLVM_GZ)
	cd src ; xzcat $< | tar x && mv $(LLVM).src $(LLVM) && touch $@

## configure

CFG = configure --disable-nls --prefix=$(PFX)
CFG_T = configure --prefix=$(TOOL)

## pack build

.PHONY: cmake
cmake: $(SRC)/$(CMAKE)/README
	rm -rf $(BUILD)/$(CMAKE) ; mkdir $(BUILD)/$(CMAKE)
	cd $(BUILD)/$(CMAKE) ; $(SRC)/$(CMAKE)/$(CFG_T)

.PHONY: llvm
llvm: $(SRC)/$(LLVM)/README.txt
	rm -rf $(BUILD)/$(LLVM) ; mkdir $(BUILD)/$(LLVM)
	cd $(BUILD)/$(LLVM) ; cmake $(SRC)/$(LLVM) && make install

