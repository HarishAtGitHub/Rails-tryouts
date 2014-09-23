Rails-tryouts
=============

This is the Hello World Ruby on Rails app.

To run do
1) Install rvm and ruby (see section below)
2) bundle install
3) Configure postgres (see the section below)
4) change the parameters in config/application.rb appropriately (it is at /etc/postgresql/<version>/main/postgresql.conf in ubuntu, and
at /var/lib/pgsql/<version>/data/pg_hba.conf in our dev box centos)
5) change the values of dbusername and password in config/database.yml to appropriate values
6) rails server -e production -p 3000

Install rvm and ruby 
====================
refer : https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-on-centos-6-with-rvm
1) sudo yum install curl
2) curl -L get.rvm.io | bash -s stable
3) source ~/.profile
4) sudo yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel
5) rvm requirements 
6) yum install postgresql-devel
7) rvm install 2.1.2
8) source ~/.rvm/scripts/rvm
9) rvm use 2.1.2 --default

Configure Postgres
==================
1) Install Postgres 
2) > sudo su postgres
3) > createuser -P <username> 
   give the password when prompted
4) > createdb <dbname>
5) Open main/pg_hba.conf from your postgres installation folder
   and add the entry 
   local   <dbname>  <username>                  md5
   to the begining of the file 
6) Now check if you are able to login using 
   psql -d <dbname> -U <username>
   if successful then set the password in the project's config/database.yml file
   under production category
7) Restart postgres , if ctf does not load (As it is witnessed at present , may be a bug)
   Restart teamforge too


