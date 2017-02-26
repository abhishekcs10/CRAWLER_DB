import os
import requests
import warnings
import shutil
from bs4 import BeautifulSoup #is case sensitive
import MySQLdb as db
con=db.connect(host='127.0.0.1', user='root' , passwd='Password#1', local_infile = 1)
cur=con.cursor()
warnings.filterwarnings('ignore')
try:
	cur.execute('CREATE DATABASE IF NOT EXISTS CSEIITKGP;')
	cur.execute('USE CSEIITKGP;')
	cur.execute('DROP TABLE IF EXISTS awards;');
	cur.execute('DROP TABLE IF EXISTS group_mem;');
	cur.execute('DROP TABLE IF EXISTS projects;');
	cur.execute('DROP TABLE IF EXISTS publications;');	
	cur.execute('DROP TABLE IF EXISTS faculty;');
	

except db.Error as err:
	print ("Failed Creating Table"+str(format(err)))
	exit(1)

TABLES={}
TABLES['faculty']=(
		"CREATE TABLE faculty("
		"	`id` int(11) NOT NULL AUTO_INCREMENT,"
		"	`name` varchar(50) NOT NULL, "
		"	`designation` varchar(100),"
		"	`responsibility` varchar(500),"
		" 	`phoneno` varchar(20),"
		"	`emailid` varchar(100),"
		"	`researcharea` varchar(4096),"
		"	`website` varchar(100),"
		"	PRIMARY KEY (`id`)"
		")	ENGINE=InnoDB")

TABLES['awards']=(
		"CREATE TABLE awards("
		"	`award_id` int(4) NOT NULL AUTO_INCREMENT,"
		"	`award_name` varchar(2048),"
		"	`award_year` varchar(6),"
		"	`f_id` int(11) NOT NULL,"
		"	PRIMARY KEY (`award_id`),"
		"	FOREIGN KEY awd_id(`f_id`) "
		"	REFERENCES faculty(`id`) ON DELETE CASCADE"
		") ENGINE=InnoDB") 

TABLES['publications']=(
		"CREATE TABLE publications("
		"	`pub_id` int(4) NOT NULL AUTO_INCREMENT,"
		"	`title_auth_journ` varchar(2048),"
		"	`year` varchar(6),"
		"	`f_id` int(11) NOT NULL,"
		"	PRIMARY KEY (`pub_id`),"
		"	FOREIGN KEY public_id(`f_id`) "
		"	REFERENCES faculty(`id`) ON DELETE CASCADE"
		") ENGINE=InnoDB")

TABLES['projects']=(
		"CREATE TABLE projects("
		"	`pro_id` int(4) NOT NULL AUTO_INCREMENT,"
		"	`title` varchar(1024),"
		"	`sponser` varchar(1024),"
		"	`f_id` int(11) NOT NULL,"
		"	PRIMARY KEY (`pro_id`),"
		"	FOREIGN KEY project_id(`f_id`) "
		"	REFERENCES faculty(`id`) ON DELETE CASCADE"
		") ENGINE=InnoDB")

TABLES['group_mem']=(
		"CREATE TABLE group_mem("
		"	`grp_id` int(4) NOT NULL AUTO_INCREMENT,"
		"	`name` varchar(100),"
		" 	`research_area` varchar(1024),"
		"	`course` varchar(10),"
		"	`f_id` int(11) NOT NULL,"
		"	PRIMARY KEY (`grp_id`),"
		"	FOREIGN KEY g_id(`f_id`) "
		"	REFERENCES faculty(`id`) ON DELETE CASCADE"
		")	ENGINE=InnoDB")

print ("here");
cur.execute(TABLES['faculty'])
cur.execute(TABLES['awards'])
cur.execute(TABLES['publications'])
cur.execute(TABLES['projects'])
cur.execute(TABLES['group_mem'])

'''
url='http://www.iitkgp.ac.in/department/CS'
base_url='http://www.iitkgp.ac.in'
r=requests.get(url)#this is get request made to fetch page
data=r.text # extract text from the page
soup=BeautifulSoup(data,'html.parser')
intext=str(soup.prettify)
intext.replace(" ","") #replaces all spaces
#print type(soup)
#print type(soup.prettify())
links=[]
tag="<a"
close_tag=">"
attr="href=\""
beg=intext.find("<h4>Faculty</h4>");
#print beg
ending=intext.find("</div>",beg);
#print ending
ind=intext.find(tag,beg,ending) #ending and beg are opening and closing of div tag
#print ind
while ind!=-1:
	start_link=intext.find(attr,ind,ending)
	start_link+=len(attr)
	#print start_link
	end_link=intext.find("\"",start_link+1)
	end_link2=intext.find(";",start_link+1,end_link)
	if(end_link2!=-1):
		end_link=end_link2
	beg=end_link+1
	#print end_link
	links.append(base_url+intext[start_link:end_link])
	ind=intext.find(tag,beg,ending)
#print links

if(os.path.exists("Faculty")):
	shutil.rmtree('Faculty/');

os.mkdir("Faculty")

os.chdir('./Faculty')
for i in links:
	r=requests.get(i)	
	data=r.text.encode('utf-8').strip()
	file_name=i.split('/')
	fp=open(file_name[-1]+".html","a+")
	print file_name[-1]
	fp.write(data)
	fp.close();
'''
	
cur.close()
con.close()
