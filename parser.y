%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

		void yyerror(const char *str);//returns an error if occured during parsing
		int yylex(void); //returns the next matching token
		FILE *fp;
		char output[2048];
		char *insert_data[11];
		int found[12]={0};
		char intermediate[2048]="";
		void modifyLine(char *str);
		%}

		/*yacc definition
		  %start defines start symbol of production rule
		  %union defines types of token to be returned by lexical analyser
		 */

		%start root 
		%union  {
				char buffer[2048];
		}

%token <buffer> IDENTIFIER
%token <buffer> STARTH3 ENDH3 STARTSPAN ENDSPAN DIVCOLLAPSEONE ULENDDIV 
%token <buffer> LIFAFAPHONE DIVCOLLAPSESEVEN LIFAFAENVELOPE ENDLIST DIVRESPTAB1 PENDDIV DIVRESPTAB2 DIVRESPTAB3 DIVRESPTAB4 WEBSITE NC END
%type <buffer> exp
%type <buffer> A B D E F H I J K ID1

%%
root 	 :  exp	
;
exp 	 :	ID1
		| ID1 exp
		| STARTH3 A ENDH3 exp
		| STARTSPAN B ENDSPAN exp
		| DIVCOLLAPSEONE C ENDLIST ULENDDIV exp
		| LIFAFAPHONE D ENDLIST exp
		| LIFAFAENVELOPE E ENDLIST exp
		| DIVRESPTAB1 F PENDDIV exp
		| WEBSITE {
		char search[2]="=>";
		char website[100];
		char *token=strtok($1,search);
		token=strtok(NULL,search);
		token=strtok(NULL,search);
		strcpy(website,token);
	 //	insert_data[10]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[10],website);

		found[10]++;
		printf("\nWebsite$ %s#",website);
		} exp
		| DIVCOLLAPSESEVEN H ULENDDIV exp
		| DIVRESPTAB2 I PENDDIV exp
		| DIVRESPTAB3 J PENDDIV exp
		| DIVRESPTAB4 K PENDDIV exp
		| PENDDIV exp
		| ULENDDIV exp
		| ENDLIST exp
		| ENDH3 exp
		| ENDSPAN exp
		| ENDH3
		| DIVRESPTAB1 PENDDIV exp
		| DIVRESPTAB2 PENDDIV exp
		| DIVRESPTAB2 DIVRESPTAB3 NC exp
		| DIVRESPTAB2 DIVRESPTAB3 J PENDDIV exp
		| DIVRESPTAB3 NC exp
		| DIVRESPTAB4 END exp
		| ENDSPAN 
		| PENDDIV
		| ULENDDIV
		| ENDLIST
		| END exp
		| END
		| NC exp
		| NC
		| error {yyerrok; }
		;

A		:  IDENTIFIER{
				   if(found[0]==0){
						   printf("Name$ ");
						   found[0]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[0]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[0],intermediate);
				   printf("%s#",$1);
				   bzero(intermediate,sizeof(intermediate));
		   }
		|  A IDENTIFIER{
				if(found[0]==0){
				printf("Name$ ");
				found[0]++;
			}
			modifyLine($2);
			sprintf(intermediate+strlen(intermediate),"%s,",$2);
			printf("%s#",$2);	
			}
			;
B		:  IDENTIFIER{
				   if(found[1]==0){
						   printf("\nDesignation$ ");
						   found[1]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[1]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[1],intermediate);
				   printf("%s#",$1); 
//				   bzero(intermediate,sizeof(intermediate));

		   }
		| B IDENTIFIER{
			if(found[1]==0){
				printf("\nDesignation$ ");
				found[1]++;
			}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	
//		bzero(intermediate,sizeof(intermediate));


		}
		; 
C		:  IDENTIFIER{
				   if(found[2]==0){
						   printf("\nResponsibility$ ");
						   found[2]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[2]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[2],intermediate);
				   printf("%s#",$1); 
//					bzero(intermediate,sizeof(intermediate));

		   }
		| C IDENTIFIER{

		if(found[2]==0){
				printf("\nResponsibility$ ");
				found[2]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	

		}

		| C ENDLIST
		| ENDLIST
		;
D		:  IDENTIFIER {

				   if(found[3]==0){
						   printf("\nPhone$ ");
						   found[3]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[3]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[3],intermediate);
				   printf("%s#",$1); 
//				   fflush(stdout);
//				   bzero(intermediate,sizeof(intermediate));

		   }
		|  D IDENTIFIER{

		if(found[3]==0){
				printf("\nPhone$ ");
				found[3]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	

		}
		;
E		:  IDENTIFIER {

				   if(found[4]==0){
						   printf("\nEmail$ ");
						   found[4]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[4]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[4],intermediate);
				   printf("%s#",$1); 
//				   fflush(stdout);
//				   bzero(intermediate,sizeof(intermediate));
		   }

		|  E IDENTIFIER{


		if(found[4]==0){
				printf("Email$ ");
				found[4]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	
		}
		;
F		:  IDENTIFIER{

				   if(found[5]==0){
						   printf("\nResearch$ ");
						   found[5]++;
				   }
				   modifyLine($1);
//				   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//				   insert_data[5]=(char *)malloc(sizeof(char)*strlen(intermediate));
//				   strcpy(insert_data[5],intermediate);
				   printf("%s#",$1); 
//				   fflush(stdout);
//				   bzero(intermediate,sizeof(intermediate));

		   }
		| F IDENTIFIER{
		if(found[5]==0)
		{
				printf("\nResearch$ ");
				found[5]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	
		}
		;
H		: IDENTIFIER{
			
				if(found[6]==0){
                           printf("\nAwards$ ");
                           found[6]++;
                   }
                   modifyLine($1);
//                   sprintf(intermediate+strlen(intermediate),"%s;",$1);
//                 insert_data[6]=(char *)malloc(sizeof(char)*strlen(intermediate));
//               strcpy(insert_data[6],intermediate);
                   printf("%s#",$1); 
//                   fflush(stdout);
 //                  bzero(intermediate,sizeof(intermediate));

	
				}
		| H ENDLIST
		| ENDLIST
		| H IDENTIFIER{

		if(found[6]==0)
		{
				printf("\nAwards$ ");
				found[6]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	


		}
		;
I		:  IDENTIFIER{
				if(found[7]==0){
                           printf("\nPublication$ ");
                           found[7]++;
                   }
                   modifyLine($1);
  //                 sprintf(intermediate+strlen(intermediate),"%s;",$1);
//                   insert_data[7]=(char *)malloc(sizeof(char)*strlen(intermediate));
//                   strcpy(insert_data[7],intermediate);
                   printf("%s#",$1); 
      //             fflush(stdout);
    //               bzero(intermediate,sizeof(intermediate));

		}
		| I IDENTIFIER{

	if(found[7]==0)
		{
				printf("\nPublication$ ");
				found[7]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	

		}
		;
J		:  IDENTIFIER{

			if(found[8]==0){
                           printf("\nProjects$ ");
                           found[8]++;
                   }
                   modifyLine($1);
  //                 sprintf(intermediate+strlen(intermediate),"%s;",$1);
//                   insert_data[8]=(char *)malloc(sizeof(char)*strlen(intermediate));
//                   strcpy(insert_data[8],intermediate);
                   printf("%s#",$1); 
 //                  fflush(stdout);
//                   bzero(intermediate,sizeof(intermediate));

			}
		|  J IDENTIFIER{

	if(found[8]==0)
		{
				printf("\nProjects$ ");
				found[8]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	



}
		;
K		:  IDENTIFIER {


	if(found[9]==0){
                           printf("\nGroups$ ");
                           found[9]++;
                   }
                   modifyLine($1);
  //                 sprintf(intermediate+strlen(intermediate),"%s;",$1);
 //                  insert_data[9]=(char *)malloc(sizeof(char)*strlen(intermediate));
 //                  strcpy(insert_data[9],intermediate);
                   printf("%s#",$1); 
                   fflush(stdout);
    //               bzero(intermediate,sizeof(intermediate));

		}
		| K IDENTIFIER{
	if(found[9]==0)
		{
				printf("\nGroups$ ");
				found[9]++;
		}
		modifyLine($2);
//		sprintf(intermediate+strlen(intermediate),"%s,",$2);
		printf("%s#",$2);	

		}
		;
ID1		:	IDENTIFIER
		;


%%


void modifyLine(char *str){
		int oplen=0;
		bzero(output,sizeof(output));
		strcpy(output,str);
		char *t=str;
		while(*str!='\0'&&(*str==' '||*str=='\t' || *str=='\n'))
		{
				str++;
		}
		int len=strlen(str);
		while(len>0 && *(str+len-1)==' '|| *(str+len-1)=='\t')
		{
				*(str+len-1)='\0';
		}

		for(int i=0;str[i]!='\0';i++){

				if(i<(strlen(str)-6) && str[i]=='&' && str[i+1]=='n' && str[i+2]=='b' && str[i+3]=='s' && str[i+4]=='p' && str[i+5]==';')
				{
						//printf("here\n");
						str+=5;
						continue;
				}
				else if(i< (strlen(str)-2) && ((str[i]==' '&&str[i-1]==' ')||str[i]=='\t'||str[i]=='\n'))
				{
						continue;
				}
				else
				{
						output[oplen++]=str[i];
				}

		}
		output[oplen]='\0';
		str=t;
		//printf("** %s** ",output);
		bzero(str,sizeof(str));
		strcpy(str,output);

}
