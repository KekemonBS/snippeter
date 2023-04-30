%{
#include <stdio.h>
//init tree
yydebug = 0;

%}

%start explist;
%token
	ID  
	OCB 
	CCB 
	OSB 
	CSB 
	OB  
	CB  
	SEP 
	EQ  
	OSTR 
	SC 
	Q   
	NUM 
	BLSEP 
;

%%

explist:
       exp SC                       {puts("exp\n");}
       | exp SC explist             {puts("exp+\n");}
       ;
exp:
   ID                               {puts("id\n");}
   | ID Q NUM                       {puts("id * num\n");}
   ; 
%%

int yyerror(const char *s) {
    fprintf(stderr, "error: %s\n", s);
    return 0;
}
