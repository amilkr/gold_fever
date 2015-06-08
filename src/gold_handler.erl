-module(gold_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {
}).

init(_, Req, _Opts) ->
	{ok, Req, #state{}}.

handle(Req, State=#state{}) ->
  {Headers, Req2} = cowboy_req:headers(Req),
  {ok, Body, Req3} = cowboy_req:body(Req2),
  io:format("Headers ~p Headers~nBody ~p~n", [Headers, Body]),
	Req4 = cowboy_req:reply(200,
        [{<<"content-type">>, <<"text/plain">>}],
        <<"gold_handler is up!">>,
        Req3),
	{ok, Req4, State}.

terminate(_Reason, _Req, _State) ->
	ok.
