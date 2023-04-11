%{
#include <stdio.h>   //mainly printing
#include "tokens.h"
%}

%option noyywrap
%x IN_B
%x IN_SB
%x IN_CB

%%

[ \t]+        //ignoring blanks
\n              {yylineno++;}

\|              {return SEP;}
;               {return  SC;}

=               {return  EQ;}
\*              {printf("Q\n"); return   Q;}

<INITIAL>{
\(              {return  OB; BEGIN(IN_B);}
\[              {return OSB; BEGIN(IN_SB);}
\{              {return OCB; BEGIN(IN_CB);}
}
<IN_B>{
\)              {return  CB; BEGIN(INITIAL);}
}
<IN_SB>{
\]              {return CSB; BEGIN(INITIAL);}
}
<IN_CB>{
\}              {return CCB; BEGIN(INITIAL);}
}

[a-zA-Z]        {return  ID;}
.               ;
%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

