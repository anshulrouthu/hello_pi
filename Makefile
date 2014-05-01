
############ ----- Cross Toolchain setup ----- ##############
BUILD_PATH:=rpi-build
TOOLCHAINPATH:=rpi-toolchain/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
CROSSPREFIX:=$(TOOLCHAINPATH)/arm-linux-gnueabihf-
CC:=$(CROSSPREFIX)gcc
CXX:=$(CROSSPREFIX)g++
RPATH:=rpi-staging/usr/lib/
CFLAGS:=-Wall -Werror -g -O2 -Wl,-rpath=$(RPATH)

############ ----- Project target ----- ##############
# change the target to what ever file name you want to build a binary
# this should match with the file name containing main() function
TARGET:=hello_pi

# if you add directories and files in the source dir add each dir below 
# e.g 
# for source/test/test.cpp file
# INC:= -Irpi-staging/usr/include/ -Isource/ -Isource/test/
# CPP_SRC:=$(wildcard source/*.cpp) $(wildcard source/test/*.cpp)

############ ----- Project include paths ----- ##############
INC:= -Irpi-staging/usr/include/ -Isource/

############ ----- Project library paths ----- ##############
LDPATH:= -Lrpi-staging/usr/include/

############ ----- Project source files ----- ##############
C_SRC:=$(wildcard source/*.c)
CPP_SRC:=$(wildcard source/*.cpp)
OBJS:=$(C_SRC:.c=.o) $(CPP_SRC:.cpp=.o)

############ ----- build main application ----- ##############

# change the ip address, pi dir location and pi username below
# and uncomment [scp] part below to automatically push built files to pi
IPADDR_PI:=192.168.1.2
DIR_PI:=workspace/
USERNAME_PI:=root

.PHONY: all
all: $(BUILD_PATH) $(TARGET)
	#@scp -r $(BUILD_PATH)/* $(USERNAME_PI)@$(IPADDR_PI):$(DIR_PI)

$(BUILD_PATH):
	       @mkdir -p $@

$(TARGET): $(OBJS)
	   @echo "Linking... $@"
	   @$(CXX) $(CFLAGS) $^ -o $(BUILD_PATH)/$@ $(LDPATH)

%.o: %.cpp
	@echo "[CXX] $<"
	@$(CXX) $(CFLAGS) $(INC) -c $< -o $@

%.o: %.c
	@echo "[CC] $<"
	@$(CC) $(CFLAGS) $(INC) -c $< -o $@

############ ----- cleaning ----- ##############

.PHONY: clean
clean:
	 rm -f source/*.o $(BUILD_PATH)/*
