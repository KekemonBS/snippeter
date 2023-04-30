%{
#include <stdio.h>   //mainly printing

//#include "tokens.h" 
//used to test lexer separately i need to include i
//yacc generated header to use its tokens

#include "y.tab.h"
%}

/*%option noyywrap*/
%x IN_B
%x IN_SB
%x IN_CB

%%

[ \t]+          //ignoring blanks
\n              yylineno++;

;               return  SC;

=               return  EQ;
\*              return   Q;

\(              BEGIN(IN_B);    return  OB; 
\[              BEGIN(IN_SB);   return OSB; 
\{              BEGIN(IN_CB);   return OCB; 

\|              return BLSEP; //separates blocks

<IN_B>{  
    \|              return SEP;
    [a-zA-Z]+       return OSTR;
    \)              BEGIN(INITIAL); return  CB;
}
<IN_SB>{  
    \|              return SEP;
    [a-zA-Z]+       return OSTR;
    \]              BEGIN(INITIAL); return CSB; 
}
<IN_CB>{     
    \|              return BLSEP; //separates blocks
    [a-zA-Z]+       return OSTR;
    \}              BEGIN(INITIAL); return CCB; 
}

[0-9]+          return  NUM;
[a-zA-Z]        return  ID;
.               ;
%%

int yywrap(void) {
    return 1;
}

//to make it run standalone
/*
int main(int argc, char **argv) {
    yylex();
    return 0;
}
*/

