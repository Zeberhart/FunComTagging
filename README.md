# README

Written with Ruby version 2.5.0 and Rails 5.1.6 

Ruby on Rails supports the Model-View-Controller pattern - that is, if you want to modify the appearance of the site, you would modify files in app/views (or app/assets/stylesheets). To modify page/routing behavior/connection to the server, go to app/controllers (or app/assets/javascript for client-side behavior). And to modify database objects, check app/models or db/. 

*Get started*

To run locally, you must go to the FunCom root folder and run `bundle install` – this will install and link all the dependencies. 
Run `rake db:reset` to make sure the database is setup and seeded. 
In a seperate terminal, run `rails s` to host the site locally. Navigate to http://localhost:3000/ in your browser to view it and confirm that everything is working

*Deployment*

To deploy to heroku, TODO WRITE THIS BIT


*Change functions*

The functions and comments that are to be tagged are pre-seeded in the database through the file db/seeds.rb. Modify this file to incorporate the changes you would like to make. Then, run `rake db:reset` to reset the database. NOTE this will wipe out any existing data in the database! 