
CWD = $(CURDIR)
GZ = $(CWD)/gz
SRC = $(CWD)/src
BUILD = $(CWD)/build
MGW = $(CWD)/mingw32

DIRS = $(GZ) $(SRC) $(BUILD) $(MGW)

.PHONY: dirs
dirs:
	mkdir -p $(DIRS)

