%{
#include<string.h>
#include<stdio.h>
#include "parser.tab.h"
int yywrap(void);
int yylex();

FILE *fp;
%}

%%

[ \r\n]+ ;

\<h3[ \r]?style=([^\>])*\> {//for name
//printf("%s\n",yytext);
strcpy(yylval.buffer,"Name :$");
return STARTH3;
}

\<\/h3[ \r]*\>[ \n]*\<p {//endtag for name
strcpy(yylval.buffer," :$END\n");

return ENDH3;
}

[ \r]*style=[ \r]*[^\>]*[ \r]*\>[ \r\n]*\<span\>[ \r\n]* {//for 
strcpy(yylval.buffer,"SPAN :$\n");
return STARTSPAN;
}
\<\/span[ \r]*\>[ \n]*\<br\>[ \r\n]*  {
strcpy(yylval.buffer,"SPAN :$\n");

return ENDSPAN;
}

\<div[ \r]*id[ \r]*=[ \r]*\"collapseOne\"[^\>]+\>[ \r\n]* {
strcpy(yylval.buffer,"SPAN :$\n");

return DIVCOLLAPSEONE;
}

\<\/ul\>[ \n]*\<\/div\>[ \r\n]*     { //ul followed by div
strcpy(yylval.buffer,"SPAN :$\n");

return ULENDDIV;

}

\<div[^\>]*id=\"collapseseven\"[^\>]*\>[ \r\n]*  {
strcpy(yylval.buffer,"SPAN :$\n");
return DIVCOLLAPSESEVEN;
}



\<i[ \r]class=\"fa[ \r]fa-phone\"\>[ \r\n]*  {
strcpy(yylval.buffer,"SPAN :$\n");

return LIFAFAPHONE;

}

\<i[ \r]class=\"fa[ \r]fa-envelope\"\>[ \r\n]* {
strcpy(yylval.buffer,"SPAN :$\n");

return LIFAFAENVELOPE;

}

\<\/li[ \r]*\>[ \r\n\t]*  {
strcpy(yylval.buffer,"SPAN :$\n");

return ENDLIST;

}


\<[ \r]*div[^\>]*id[ \r]*=[ \r]*\"resp-tab1\"[^\>]*\>[ \r\n]*  {strcpy(yylval.buffer,"SPAN :$\n");

return DIVRESPTAB1;
}

\<[ \r]*div[^\>]*id[ \r]*=[ \r]*\"resp-tab2\"[^\>]*\>[ \r\n]*  {strcpy(yylval.buffer,"SPAN :$\n");

return DIVRESPTAB2;
}

\<[ \r]*div[^\>]*id[ \r]*=[ \r]*\"resp-tab3\"[^\>]*\>[ \r\n]*  {strcpy(yylval.buffer,"SPAN :$\n");

return DIVRESPTAB3;
}

\<[ \r]*div[^\>]*id[ \r]*=[ \r]*\"resp-tab4\"[^\>]*\>[ \r\n]*  {strcpy(yylval.buffer,"SPAN :$\n");

return DIVRESPTAB4;
}

\<a[ \r]*target=\"_blank\"[^\>]*\>[ \r\n]*Website[ \r\n]*  {//edit for website
strcpy(yylval.buffer,yytext);

return WEBSITE;
}

\<[^\>]*NOT[ \r\t]*COMPLETED[^\>]*\>  {
//printf("here");
return NC;
}

\<[^\>]*Body[ \r\t]*Content[ \r\t]*End[^\>]*\>  {
//printf("here");
return END;
}


[ \r\n]*\<\/p\>[ \n\r]*\<\/div\>[ \r\n]*  { //ul followed by div
strcpy(yylval.buffer,"SPAN :$\n");

return PENDDIV;

}


\<[ \r]*[0-9a-zA-Z]+[^\>]*[ \r]*\>[ \r\n]*	;
\<[ \r]*\/[0-9a-zA-Z]+[^\>]*[ \r]*\>[ \r\n]*	;



[a-zA-Z0-9:\& \n\+\t\r\-\/\;\@\.\,\(\)\[\]]+ {
//printf("Name %s\n",yytext);
strcpy(yylval.buffer,yytext);

//printf(":) %s :)",yytext);
return IDENTIFIER;
}


. ;

%%

int yywrap(void)
{
//printf("End of parsing \n");
return 1;
}

void yyerror(const char *str)
{
 printf(" Invalid Character ***%s...\n",yytext);
}

int main()
{
// printf(" Start of parsing ");
    // parse through the input until there is no more:

int k=0;
if(k==1){

int ntoke=yylex();
while(ntoke)
{
printf("%d\n",ntoke);
ntoke=yylex();
}
return 0;
}
else
  return  yyparse();
   
 //value();
}


