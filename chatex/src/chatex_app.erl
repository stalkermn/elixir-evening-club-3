%%%-------------------------------------------------------------------
%% @doc chatex public API
%% @end
%%%-------------------------------------------------------------------

-module(chatex_app).

-behaviour(application).

%% Application callbacks
-export([start/0]).
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================
start() -> 
	application:ensure_all_started(chatex).

nodes_discovery() -> 
	application:ensure_all_started(nodefinder),
	nodefinder:multicast_start(),
	nodefinder:multicast_discover(5000),
	timer:sleep(1000),
	ok.

start(_StartType, _StartArgs) ->
	nodes_discovery(),
	syn:init(),
    chatex_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
