%%%-------------------------------------------------------------------
%% @doc dcache public API
%% @end
%%%-------------------------------------------------------------------

-module(dcache_app).

-behaviour(application).


%% Application callbacks
-export([start/2, stop/1]).
-export([start/0]).

% -export([start_phase/3]).

%%====================================================================
%% API
%%====================================================================
start() -> 
	application:ensure_all_started(dcache).

start(_StartType, _StartArgs) ->
	dcache:start(),
    dcache_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

% start_phase(connect_nodes, _StartType, []) -> 
% 	[ begin 
% 		erlang:set_cookie(Node, Cookie),
% 		net_kernel:connect_node(Node)
% 	 end || {Node, Cookie} <- maps:to_list(application:get_env(nodes))].


