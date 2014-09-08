gotongroyong20
==============
Gotong Royong 2.0

Major components
-----------
1) Ruby on Rails 4.1.5
2) PostgreSQL
3) AngularJS
4) Bootstrap

Setting up development environment
-------------------------------------
1) Fork from this Github
2) 

    git clone <your repo>
    cd <project folder>
    bundle
3) Correct config/database.yml to your Postgres configuration
4) Rename config/application.yml.sample to config/application.yml
5)

    rake db:migrate
    rake db:seed
    rake location:fetch_geocode #fetch geocode data from Google. Limited to 2,500 request/day
    rails s