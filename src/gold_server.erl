-module(gold_server).

-behaviour(gen_server).

-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-export([start_link/1]).

start_link(Args) ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).

init(_Args) ->
  {ok, #{}}.

handle_call(Request, From, State) -> 
  io:format("handle_call -> From ~p. Request ~p ~n", [From, Request]),
  {reply, ok, State}.


handle_cast(Request, State) ->
  io:format("handle_cast -> Request ~p State ~p ~n", [Request, State]),
  {noreply, State}.

handle_info(stop, State) ->
  io:format("handle_info -> stop~n"),
  {stop, normal, State};

handle_info(Info, State) ->
  io:format("handle_info -> Info ~p State ~p ~n", [Info, State]),
  {noreply, State}.

terminate(Reason, State) ->
  io:format("terminate -> Reason ~p State ~p ~n", [Reason, State]),
  ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.



% o le paso el pid o registro el gen_server como mapa
