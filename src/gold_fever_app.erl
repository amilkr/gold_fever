-module(gold_fever_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
    {'_', [
      {"/", gold_handler, []},
      {"/pocket", gold_handler, []}
    ]}
  ]),
  {ok, _} = cowboy:start_http(gold_fever_http, 100,
    [{port, 8080}], [{env, [{dispatch, Dispatch}]}]),

	gold_fever_sup:start_link().

stop(_State) ->
	ok.
