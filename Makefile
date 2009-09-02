CC=gcc
CXX=g++
CPPFLAGS=-g -I/usr/include/xplc-0.3.13 -I/usr/include/wvstreams -Wall

default: all

all: jfauthd

jfauthd: LIBS+=-lwvstreams -lpam
jfauthd: jfauthd.o authpam.o

# Cheap and easy: all the .o files depend on all the .h files.
$(patsubst %.cc,%.o,$(wildcard *.cc)) $(patsubst %.c,%.o,$(wildcard *.c)): \
	$(wildcard *.h)

%.o: %.cc
	$(CXX) -c -o $@ $< ${CPPFLAGS} ${CXXFLAGS}

%.o: %.c
	$(CC) -c -o $@ $< ${CPPFLAGS} ${CFLAGS}

%: %.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LIBS)
	
clean::
	rm -f *~ *.o jfauthd