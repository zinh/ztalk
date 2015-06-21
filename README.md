ztalk
=====

An OTP application

Build
-----

### Dev environment

    $ ./rebar3 compile, release
    $ _build/default/rel/ztalk/bin/ztalk console
    
### Production environment

    $ REBAR_DEFAULT_PROFILE=prod ./rebar3 tar
