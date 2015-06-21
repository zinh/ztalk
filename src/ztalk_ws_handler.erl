-module(ztalk_ws_handler).
-export([init/3, websocket_init/3, websocket_handle/3, websocket_info/3, websocket_terminate/3]).
-record(state, {username, login = false}).
-define(WSKey, {pubsub, ws_socket}).

init({tcp, http}, _Reg, _Opts) ->
  {upgrade, protocol, cowboy_websocket}.

websocket_init(tcp, Req, _Opts) ->
  State = #state{login = false},
  {ok, Req, State}.

websocket_handle({text, Msg}, Req, #state{login = false} = State) ->
  Login = Msg,
  gproc:reg({p, l, ?WSKey}),
  NewState = State#state{username = Login, login = true},
  {reply, {text, <<"Hello ", Login/binary, "!">>}, Req, NewState};

websocket_handle({text, Msg}, Req, #state{login = true} = State) ->
  broadcast(State#state.username, Msg),
  {ok, Req, State}.

websocket_info({_Pid, ?WSKey, Msg}, Req, State) ->
  {reply, {text, Msg}, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
  gproc:unreg({p, l, ?WSKey}),
  ok.

%% Private functions
broadcast(Name, Msg) ->
  gproc:send({p, l, ?WSKey}, {self(), ?WSKey, <<Name/binary, ": ", Msg>>}).
