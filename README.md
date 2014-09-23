Rails-tryouts
=============

This is the Hello World Ruby on Rails app.

To run do
1) bundle install
3) Configure postgres (see the section below)
2) rails server -e production -p 3000

Configure Postgres
==================
1) Install Postgres 
2) > sudo su postgres
3) > createuser -P iaf_dbuser 
   give the password when prompted
4) > createdb iaf_external
5) Open main/pg_hba.conf from your postgres installation folder
   and add the entry 
   local   ctf_binary_prod  binary_production_user                  md5
   to the begining of the file 
6) Now check if you are able to login using 
   psql -d iaf_external -U iaf_dbuser
   if successful then set the password in the project's config/database.yml file
   under production category


