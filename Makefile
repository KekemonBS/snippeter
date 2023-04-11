CC=gcc
CFLAGS=-Wall -Wunused

SOURCES=$(wildcard *.c)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=snippeter
LEXFILE=lexer.l
YACCFILE=parser.y

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXECUTABLE)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

lex:
	lex $(LEXFILE)

yacc: lex
	yacc -W $(YACCFILE)
	
clean:
	rm -f $(OBJECTS) $(EXECUTABLE) $(wildcard .yy.c) $(wildcard *.tab.c)
