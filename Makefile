.PHONY: all
all: llvm

## versions

LLVM_VER = 3.9.1

## dirs

CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
BUILD = $(CWD)/build
PFX = $(CWD)/mingw32

DIRS = $(GZ) $(SRC) $(BUILD) $(PFX)

.PHONY: dirs
dirs:
	mkdir -p $(DIRS)

## packages

LLVM = llvm-$(LLVM_VER)
LLVM_GZ = $(LLVM).src.tar.xz
LLVM_URL = http://releases.llvm.org/$(LLVM_VER)/$(LLVM_GZ)

WGET = wget -c --no-check-certificate -P $(GZ) 
.PHONY: gz
gz: $(GZ)/$(LLVM_GZ)
$(GZ)/$(LLVM_GZ):
	$(WGET) http://releases.llvm.org/3.9.1/llvm-3.9.1.src.tar.xz && touch $@

## sources

.PHONY: src
src: $(SRC)/$(LLVM)/README

$(SRC)/$(LLVM)/README.txt: $(GZ)/$(LLVM_GZ)
	cd src ; xzcat $< | tar x && mv $(LLVM).src $(LLVM) && touch $@

## configure

CFG = configure --disable-nls --prefix=$(PFX)

## pack build

.PHONY: llvm
llvm: $(SRC)/$(LLVM)/README.txt
	rm -rf $(BUILD)/$(LLVM) ; mkdir $(BUILD)/$(LLVM)
	cd $(BUILD)/$(LLVM) ; cmake $(SRC)/$(LLVM)

