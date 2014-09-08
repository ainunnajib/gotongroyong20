gotongroyong20
==============
Gotong Royong 2.0

Major components
-----------
1. Ruby on Rails 4.1.5
2. PostgreSQL
3. AngularJS
4. Twitter Bootstrap

Setting up development environment
-------------------------------------
1) Fork from this Github

2) Correct config/database.yml to your Postgres configuration

    git clone <your repo>
    cd gotongroyong20
    bundle
    mv config/application.yml.sample config/application.yml
    rake db:migrate
    rake db:seed
    rake location:fetch_geocode #fetch geocode data from Google. Limited to 2,500 request/day
    rails s