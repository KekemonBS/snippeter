//#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
//#include <errno.h>
#include <string.h>
//#include <unistd.h>
//#include "tokens.h"

#pragma pack(1)

//some external functions in lex.yy.c
extern int yylex();
extern int yylineno;
extern char* yytext;
extern FILE* yyin;

//---------------------------------
//          args handling
//----------------------------------
typedef struct {
    char name[12]; 
    int(*fp)(char *argp);
} arg; 

int
fp1(char *argp)
{
    return 0;
}

int
fp2(char *argp)
{
    return 0;
}

arg opts[] = {
    {.name = "name1", .fp = &fp1},
    {.name = "name2", .fp = &fp2},
};

int(*
        searchArg(char *argname)
   )(char *)
{
    for (int i = 0; i < sizeof(opts)/sizeof(arg); ++i) {
        if (!strcmp(opts[i].name, argname)) { 
            return opts[i].fp;
        }
    }
    return NULL;
}
//----------------------------------

//----------------------------------
//       slice implementation 
//----------------------------------

//interface
typedef struct {
    int (*append)(void *data, char i);
} sliceInterface;

//implementation
typedef struct {
    int ocupied;
    int size;
    char *data;
    sliceInterface si;
} slice;

int appendImpl(void *data, char i) {
    slice *s = (slice *)data; 
    if ((*s).ocupied == (*s).size) {
        char *datan = realloc((*s).data, (*s).size*2*sizeof(i));
        if (datan == NULL) {
            perror("realloc");
            exit(EXIT_FAILURE);
        }
        (*s).size = (*s).size * 2; 
        (*s).data = datan;
    }
    *((*s).data+sizeof(i)*(*s).ocupied) = i;
    (*s).ocupied++;
    return 1; 
}

slice sliceNew() {
    return (slice){
        .ocupied = 0,
        .size = 1,
        .si = (sliceInterface){
            &appendImpl,
        },
        .data = malloc(sizeof(char)),
    };
}

int sliceDestruct(slice* s) {
    free((*s).data);
    return 1;
}
//----------------------------------

int 
main(int argc, char *argv[])
{
    if (stdin == NULL){
        return 1; 
    }

    slice s = sliceNew();
    
    int(*fp)(void *, char);
    fp = s.si.append;
    
    //printf("%p\n", s.si.append);

    char c;
    while ((c = fgetc(stdin)) != EOF) {
        int ok = (*fp)(&s, c);
        if (!ok) {
            perror("failed to append\n");
            exit(EXIT_FAILURE);
        }
    }
    printf("%s\n",  s.data); 
    //printf("%p\n", s.si.append);

    //(*((*(s.si)).append))(&s, c);
    
    yyin = fmemopen(s.data, strlen(s.data), "r");
    int token = yylex();
    while(token) {
        printf("%d --- %d\n", yylineno, token);
        token = yylex();
    }
    //parse
   
    if (!sliceDestruct(&s)) {
        perror("unable to deallocate slice\n");
        exit(EXIT_FAILURE);
    }

    return 0;
}
