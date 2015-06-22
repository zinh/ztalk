%%%-------------------------------------------------------------------
%% @doc ztalk public API
%% @end
%%%-------------------------------------------------------------------

-module('ztalk_app').

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
  start_cowboy(),
  ztalk_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
  ok.

%%====================================================================
%% Internal functions
%%====================================================================

start_cowboy() ->
  Dispatch = cowboy_router:compile([
      {'_', [
          {"/static/[...]", cowboy_static, {priv_dir, ztalk, "static", [{mimetypes, cow_mimetypes, web}]}},
          {"/", cowboy_static, {priv_file, ztalk, "static/index.html"}},
          {"/ws", ztalk_ws_handler, []}
        ]}
    ]),
  ListenPort = case os:getenv("PORT") of
    false ->
      8080;
    P ->
      erlang:list_to_integer(P)
  end,
  cowboy:start_http(ztalk_cowboy, 100, [{port, ListenPort}], [{env, [{dispatch, Dispatch}]}]).
