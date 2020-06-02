
APP:=BlockSimulatedKingdom

SRC_CC := $(wildcard ./src/*.cc)
SRC := $(notdir $(SRC_CC:%.cc=%))
OBJ := $(SRC:%=bin/%.o)

#sudo apt install libx11-dev libepoxy-dev libunittest++-dev

PKGS := epoxy x11 UnitTest++

CFLAGS := -Wall -O3 -std=c++17 -MMD
LDLIBS := -lstdc++ -pthread

# Phony targets
.PHONY: all clean debug env

#
# Bulid app
#
all: $(APP)
	@echo Done making $(APP)

#
# Debug the app
#
debug: CFLAGS += -g3
debug: all

#
# Compile
#
bin/%.o: src/%.cc
	@mkdir -p bin/
	@echo compiling $<
	@$(CXX) -c $(CFLAGS) $(CPPFLAGS) -o $@ $< 

#
# Link
#
$(APP): $(OBJ)		
	@echo linking $@
	@$(CXX) -o $@ $(OBJ) $(LDFLAGS) $(LDLIBS)

env:
	@echo "SRC = $(SRC)"
	@echo ""		
	@echo "OBJ = $(OBJ)"
#
# Clean
#
clean:
	@echo cleaning
	@rm -f bin/*
	@rm -f $(APP)

-include $(OBJ:.o=.d)		
