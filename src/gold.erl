-module(gold).
-export([main/0, listen/0]).

main() ->
      net_adm:ping('gold_fever@192.168.88.161'),
      process_flag(trap_exit, true),
       % ping
       register('larry', self()),
       
       #{instructions := _, kathy := Kathy, token := Token} = listen(),
       Kathy ! flower,
       listen(),
       start_server(Kathy, Token),
       {monitored_by, [Monitor]} = rpc:pinfo(Kathy, monitored_by),
       erlang:exit(Monitor, kill),
       listen(),
      
      ask_colors(Kathy, Token), 
      gen_server:call({kathy, 'gold_fever@192.168.88.161'}, #{token => Token, name => larry}),
      gen_server:cast({kathy, 'gold_fever@192.168.88.161'}, #{token => Token, address => "http://192.168.88.46:8080"}),

       % unregister('larry').

listen() ->
	 receive
		M -> 
		io:format("~p~n", [M]),
		M
	 after 2000 ->
	       	no_message
	 end.

% start_server() ->
%   Kathy = list_to_pid("<6768.6065.0>"),
% 	Token = <<"JPmCqki0btxRfUETQbjIdg==">>,
%   start_server(Kathy, Token).

start_server(Kathy, Token) ->
  {ok, Pid} = gold_server:start_link([]),
  Kathy ! #{token => Token, name => gold_server, pid => Pid},
  listen().

ask_colors(Kathy, Token) ->
  ask_colors(Kathy, Token, 5).

ask_colors(_Kathy, _Token, 0) ->
  ok;
ask_colors(Kathy, Token, N) ->
  gen_fsm:sync_send_event(Kathy,
                          #{token => Token,
                            question => "What color are the flowers?"}),
  ask_colors(Kathy, Token, N - 1).