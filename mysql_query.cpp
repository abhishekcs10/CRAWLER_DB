#include<mysql/my_global.h>
#include<mysql/mysql.h>
#include<cstdio>
#include<iostream>
#include<vector>
#include<string>
using namespace std;

void trimspace(string &s)
{
int i=0,j=0;
string s2="";
for(int i=0;i<s.length();i++)
if(s[i]==' '&&s[i+1]==' ')
{
continue;
}
else
{
s2+=s[i];
}

s=s2;

}

void finish_with_error(MYSQL *con)
{
  fprintf(stderr, "%s\n", mysql_error(con));
  mysql_close(con);
  exit(1);        
}


string get_id(MYSQL *con,string name )
{

string exe="Select id from faculty where name = '"+name+"';";
if(mysql_query(con,exe.c_str())){
  finish_with_error(con);
}


 MYSQL_RES *result = mysql_store_result(con);
  
  if (result == NULL) 
  {
      finish_with_error(con);
  }

  int num_fields = mysql_num_fields(result);
string id="";
  MYSQL_ROW row;
  
  while ((row = mysql_fetch_row(result))) 
  { 
      for(int i = 0; i < num_fields; i++) 
      { 
         // printf("%s ", row[i] ? row[i] : "NULL"); 
			id=row[i];
      } 
          //printf("\n"); 
  }
  

  mysql_free_result(result);
return id;

}

int main(int argc, char *argv[]){
vector<string> query(11,"");
vector<int> done(11,0);
vector<pair<string,string> > awards;
vector<pair<string,string> > projects;
vector<pair<string,string> > group_mem_phd;
vector<pair<string,string> > group_mem_ms;
vector<pair<string,string> > publication;

FILE *fp=fopen(argv[1],"r");
size_t line=80;
ssize_t ret;
char *read_line=(char *) malloc(sizeof(char)*80);
MYSQL *con=mysql_init(NULL);
if(con==NULL)
{
fprintf(stderr,"%s\n", mysql_error(con));
exit(1);
}
if(mysql_real_connect(con,"localhost","root","Password#1",NULL,0,NULL,0)==NULL){
fprintf(stderr,"%s\n",mysql_error(con));
mysql_close(con);
}

if(mysql_query(con,"USE CSEIITKGP;"))
{
 fprintf(stderr, "%s\n", mysql_error(con));
      mysql_close(con);
      exit(1);
}

if(mysql_query(con,"SHOW TABLES;")){
  finish_with_error(con);
}


 MYSQL_RES *result = mysql_store_result(con);
  
  if (result == NULL) 
  {
      finish_with_error(con);
  }

  int num_fields = mysql_num_fields(result);

  MYSQL_ROW row;
  
  while ((row = mysql_fetch_row(result))) 
  { 
      for(int i = 0; i < num_fields; i++) 
      { 
       //   printf("%s ", row[i] ? row[i] : "NULL"); 
      } 
         // printf("\n"); 
  }
  

  mysql_free_result(result);
//0-name 1-designation 2-responsibility 3-phone 4-email 5-research 6-website 7-awards 8-publication 9-project 10-group 
char tagging[25];
string val="";
while((ret=getline(&read_line,&line,fp))>0){

char tok[4]="$#\n";
char *tag=strtok(read_line,tok);
strcpy(tagging,tag);
//printf("%s\n",tag);
if(strcmp(tagging,"Awards")==0)
{
//for awards table
while(tag!=NULL)
{
if(strlen(tag)>0)
{
//printf("%s\n",tag);
}
tag=strtok(NULL,tok);
if(tag!=NULL)
{

val=string(tag);
if(val[val.length()-1]<='9'&&val[val.length()-1]>='0')
{
string s1=val.substr(0,val.length()-5);
string s2=val.substr(val.length()-4,4);
//cout<<"inded*** "<<s1<<" "<<s2<<endl;
awards.push_back(make_pair(s1,s2));
}
else
{
awards.push_back(make_pair(val,"NULL"));
}
}

}

}

else if (strcmp(tagging,"Groups")==0){
//case for group_mem table
int phd=1;
int  talk=0;
while(tag!=NULL)
{
if(strlen(tag)>0)
{
//printf("%s\n",tag);
}
if(!talk)
tag=strtok(NULL,tok);
else
talk=0;
if(tag!=NULL )
{val=string(tag);
if((strcmp(tag," Ph.D.")==0)||(strcmp(tag,"Students")==0))
{
continue;
}
if((strcmp(tag,"MS")==0)||(strcmp(tag,"Students")==0))
{
phd=0;
continue;
}
}

string sch_name="",res_area="";
if(tag!=NULL)
{
sch_name=string(tag);
tag=strtok(NULL,tok);
tag=strtok(NULL,tok);


if(tag!=NULL)
{
res_area=string(tag);
}

}

if(tag!=NULL && strcmp(tag,"Chandana Roy")==0)
{
res_area="";
talk=1;
}
if(tag!=NULL )
{val=string(tag);
if((strcmp(tag," Ph.D.")==0)||(strcmp(tag,"Students")==0))
{
res_area="NULL";
}
if((strcmp(tag,"MS")==0)||(strcmp(tag,"Students")==0))
{
res_area="NULL";
phd=0;
}
}
if(phd && sch_name.length()>1)
{
group_mem_phd.push_back(make_pair(sch_name,res_area));
}
else 
{
if(sch_name.length()>1)
group_mem_ms.push_back(make_pair(sch_name,res_area));
}



}



}
else if (strcmp(tagging,"Projects")==0){
//case for projects table
while(tag!=NULL)
{
if(strlen(tag)>0)
{
//printf("%s\n",tag);
}
string title="",sponser="";

tag=strtok(NULL,tok);
if(tag!=NULL)
{
val+=string(tag);
title=string(tag);
}

tag=strtok(NULL,tok);
if(tag!=NULL)
{val+=string(tag);
sponser=string(tag);
}

if(title.length()>0 && sponser.length()>0)
{
projects.push_back(make_pair(title,sponser));
}
else if(title.length()==0 && sponser.length()>0)
projects.push_back(make_pair("NULL",sponser));
else if(title.length()>0 && sponser.length()==0)
projects.push_back(make_pair(title,"NULL"));
else
continue;
}

}

else if (strcmp(tagging,"Publication")==0){
//case for projects table
string pub="",yop="";
while(tag!=NULL)
{
if(strlen(tag)>0)
{
//printf("%s\n",tag);
}
tag=strtok(NULL,tok);
if(tag==NULL)
break;
if(strlen(tag)>2 && tag[0]=='(' && tag[1]>='0' && tag[1]<='9')
{
yop=string(tag).substr(1,4);
publication.push_back(make_pair(pub,yop));
pub="";
yop="";
}
else
{
pub+=string(tag);
}

}
}
else
{
//this is case when tag belong to faculty table
while(tag!=NULL)
{
if(strlen(tag)>0)
{
//printf("%s\n",tag);
}
tag=strtok(NULL,tok);
if(tag!=NULL)
val+=string(tag);

}

}
if(strcmp("Name",tagging)==0)
{
query[0]=val;
done[0]=1;
}

if(strcmp("Designation",tagging)==0)
{
query[1]=val;
done[1]=1;
}

if(strcmp("Responsibility",tagging)==0)
{
query[2]=val;
done[2]=1;
}

if(strcmp("Phone",tagging)==0)
{
query[3]=val;
done[3]=1;
}

if(strcmp("Email",tagging)==0)
{
query[4]=val;
done[4]=1;
}
if(strcmp("Research",tagging)==0)
{
query[5]=val;
done[5]=1;
}

if(strcmp("Website",tagging)==0)
{
query[6]=val;
done[6]=1;
}

if(strcmp("Awards",tagging)==0)
{
query[7]=val;
done[7]=1;
}

if(strcmp("Publication",tagging)==0)
{
query[8]=val;
done[8]=1;
}

if(strcmp("Projects",tagging)==0)
{
query[9]=val;
done[9]=1;
}

if(strcmp("Groups",tagging)==0)
{
query[10]=val;
done[10]=1;
}

val="";
//printf("\nEnd tag\n");

}


for(int i=0;i<11;i++)
{
if(done[i])
{
//cout<<query[i]<<endl;
}
else
{
//cout<<"NULL"<<endl;
query[i]="NULL";
}
}

if(done[0])
{
trimspace(query[0]);
//cout<<"Name " <<query[0]<<endl;
}
if(done[1]){

trimspace(query[1]);
//cout<<"Designation "<<query[1]<<endl;

}
if(done[2])
{trimspace(query[2]);
//cout<<"responsibility "<<query[2]<<endl;
}
if(done[3])
{trimspace(query[3]);
//cout<<"phoneno "<<query[3]<<endl;
}
if(done[4])
{trimspace(query[4]);
//cout<<"email "<<query[4]<<endl;
}
if(done[5])
{trimspace(query[5]);
//cout<<"researcharea "<<query[5]<<endl;
}
if(done[6]){
trimspace(query[6]);
//cout<<"website "<<query[6]<<endl;
}

string execute="INSERT INTO faculty (name,designation,responsibility,phoneno,emailid,researcharea,website) values ( '"+query[0]+"','"+query[1]+"','"+query[2]+"','"+query[3]+"','"+query[4]+"','"+query[5]+"','"+query[6]+"')";

cout<<execute<<endl;
if(mysql_query(con,execute.c_str()))
{
finish_with_error(con);
}
if(mysql_commit(con))
{
cout<<"not commited"<<endl;
}
execute="";

string fac_id=get_id(con,query[0]);
cout<<fac_id<<endl;





string query_award="INSERT INTO awards (award_name,award_year,f_id) values ('";
string erp="";
if(done[7])
{
cout<<"Award\n";
for(int i=0;i<awards.size();i++){
trimspace(awards[i].first);
trimspace(awards[i].second);
//cout<<awards[i].first<<" Year "<<awards[i].second<<endl;
erp=awards[i].first+"','"+awards[i].second+"',"+fac_id+")";
execute=query_award+erp;
cout<<execute<<endl;
if(mysql_query(con,execute.c_str()))
{
cout<<"error"<<endl;
finish_with_error(con);
}
erp="";
execute="";

}

}

else
{
cout<<"Award\nNULL"<<endl;

}

string query_pub="INSERT INTO publications (title_auth_journ,year,f_id) values ('";
erp="";

if(done[8])
{
cout<<"Publication"<<endl;
for(int i=0;i<publication.size();i++)
{

trimspace(publication[i].first);
trimspace(publication[i].second);
//cout<<publication[i].first<<" Year "<<publication[i].second<<endl;
erp=publication[i].first+"','"+publication[i].second+"',"+fac_id+")";
execute=query_pub+erp;
cout<<execute<<endl;
if(mysql_query(con,execute.c_str()))
{
finish_with_error(con);
}
erp="";
execute="";


}
}
else
{
cout<<"Publication\nNULL"<<endl;
}

string query_proj="INSERT INTO projects (title,sponser,f_id) values ('";
erp="";


if(done[9])
{
cout<<"Projects"<<endl;

for(int i=0;i<projects.size();i++){
trimspace(projects[i].first);
trimspace(projects[i].second);
//cout<<projects[i].first<<" Year "<<projects[i].second<<endl;
erp=projects[i].first+"','"+projects[i].second+"',"+fac_id+")";
execute=query_proj+erp;
cout<<endl;
if(mysql_query(con,execute.c_str()))
{
finish_with_error(con);
}
erp="";
execute="";


}

}

else
{
cout<<"Project\nNULL"<<endl;

}
string query_grp="INSERT INTO group_mem (name,research_area,course,f_id) values ('";
erp="";


if(done[10])
{
cout<<"Groups\nPhd\n"<<endl;
for(int i=0;i<group_mem_phd.size();i++)
{
trimspace(group_mem_phd[i].first);
trimspace(group_mem_phd[i].second);
//cout<<group_mem_phd[i].first<<" Area "<<group_mem_phd[i].second<<endl;
erp=group_mem_phd[i].first+"','"+group_mem_phd[i].second+"','"+"phd"+"',"+fac_id+")";
execute=query_grp+erp;
cout<<execute<<endl;
if(mysql_query(con,execute.c_str()))
{
finish_with_error(con);
}
erp="";
execute="";


}
cout<<"MS"<<" "<<group_mem_ms.size()<<endl;

for(int i=0;i<group_mem_ms.size();i++)
{
trimspace(group_mem_ms[i].first);
trimspace(group_mem_ms[i].second);
//cout<<group_mem_ms[i].first<<" Area "<<group_mem_ms[i].second<<endl;
erp=group_mem_ms[i].first+"','"+group_mem_ms[i].second+"','"+"ms"+"',"+fac_id+")";
execute=query_grp+erp;
cout<<execute<<endl;
if(mysql_query(con,execute.c_str()))
{
finish_with_error(con);
}
erp="";
execute="";


}
}

else
{
cout<<"Group\nNULL"<<endl;

}

mysql_close(con);
  exit(0);
}
