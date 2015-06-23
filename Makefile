compile:
	./rebar3 do compile

run:
	./rebar3 do shell

clean:
	./rebar3 clean

tar:
	./rebar3 as prod tar

release:
	./rebar3 do release

all: compile run
