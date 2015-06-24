ztalk
=====

An OTP application

Build
-----

### Compile release for dev environment

    $ make release
    $ _build/default/rel/ztalk/bin/ztalk console
    
### Production environment

    $ make tar

### Deploy to heroku

Using heroku cli tool `heroku`

    $ heroku create --buildpack "https://github.com/heroku/heroku-buildpack-erlang.git"
    $ git push heroku master
    $ heroku scale web=1
