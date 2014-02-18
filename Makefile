CLANG_LEVEL := ../..
LIBRARYNAME = OpenTool

LINK_LIBS_IN_SHARED = 0
SHARED_LIBRARY = 1

CXX_PP  := clang++
CXX_CC  := clang
CXX_AR  := ld



#----------------------------
# Common C++ compile with flags 
# and application include paths.

CLIENT_APP := $(CXX_PP) -O3 -target duetto
SERVER_APP := $(CXX_PP) -O3 -duetto-side=server 

#----------------------------
# Common linker with flags 
# for application library path.

LINK_APP := $(CXX_PP)

BASE_DIR = .

SRC_DIR  = $(BASE_DIR)

INC_DIR  := -I$(SRC_DIR)

TARGET_LIB = $(BASE_DIR)/build

SRCS := /opt/duetto/share/duetto/server_stub.cpp
SRCS += /opt/duetto/share/duetto/deserializer.cpp
SRCS += $(SRC_DIR)/TorqueTalk.cpp

OBJS := $(SRCS:.cpp=.o)

TARGET := $(TARGET_LIB)/TorqueTalk

LIB := -lrt
LIB += -lboost_system 
LIB += -lpion-net-4.0
LIB += -lpthread
LIB += -lpion-common-4.0
LIB += -lboost_thread 
LIB += -lssl 
LIB += -lcrypto 
LIB += -llog4cpp
###############################################################
# Compiler Flags Additions

CXX_FLAGS = -std=c++11 -Wall -fPIC  #$(INC_DIR) $(GLOBAL_INC) 

###################################################################
# Target groups
# 
.PHONY: libs apps test TorqueTalk depend clean

all: apps

libs: 
apps: TorqueTalk
test:

TorqueTalk: $(TARGET) 

$(TARGET): $(OBJS) Makefile
	   $(SERVER_APP) -o $(TARGET) $(OBJS) $(LIB)

###################################################################
.cpp.o:    
	$(CXX_PP) $(CXX_FLAGS) -c -o $@ $< 

###################################################################
clean:
	rm -f $(OBJS)
	rm -f $(TARGET)
		    
###################################################################
