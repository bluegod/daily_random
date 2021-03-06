# Daily Random

#### Fortune cookies in your e-mail, daily!

**New!** Unsubscribe feature

### Version
0.1 Beta

### Tech

DailyRandom uses a number of projects to work properly:
* Redis
* postgreSQL
* Bundler
* Ruby (tested on v2.1.2)
* Fortune cookie API as a seed: http://docs.fortunecookie.apiary.io/

### Installation

```sh
$ git clone git@github.com:bluegod/daily_random.git daily_random
$ cd daily_random
$ bundle install
$ rake db:setup #this should run after the next config step and while Redis is running!
```

Copy config/application.example.yml to config/application.yml and edit accordingly.
Edit config/environments/development.rb to use your own e-mail settings. See [http://guides.rubyonrails.org/configuring.html#configuring-action-mailer]

Also, run the scheduler and the worker to e-mail the jobs every day:

```sh
$ rake jobs:daily #add daily job 
$ rake jobs:worker #run worker (should be kept running)
```
_The scheduled time the job runs can also be changed. We could also delete the main scheduled job from the jobs page (see Admin section)_

```ruby
    #add recurring daily job
    queue.recur(DailyQuoteManager, {}, 3600*24) #update recurring time in seconds
```   

In another tab:
```sh
$ rails s #or your favourite web server
```
Access the app at: localhost:3000

### Testing/Specs

Can be run using:
```sh
$ rspec spec
```

### Todo's

* Write more integration tests
* Add performance test and update batch size and pool accordingly

### Admin stuff
At the moment is possible to delete and see the list of emails at
http://localhost:3000/subscribers

and access the web interface for the queue system at:
http://localhost:3000/jobs

_see application.example.yml and set your user/password in application.yml_

License
----
GPL v2
