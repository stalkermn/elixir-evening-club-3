-module(dcache).

-include("dcache.hrl").

-export([start/0]).
-export([get/1, set/2, del/1]).

start() -> 
	Nodes = [node() | nodes()],
	rpc:multicall(Nodes, mnesia, stop, []),
	mnesia:create_schema(Nodes),
	rpc:multicall(Nodes, mnesia, start, []),
	mnesia:create_table(dcache, [
		{ram_copies, Nodes},
		{type, set},
		{attributes, record_info(fields, dcache)}
	]).

-spec get(Key :: term()) -> Val :: not_found | term().
get(Key) -> 
	case mnesia:dirty_read(dcache, Key) of
		[] -> not_found;
		[#dcache{value = Val}] -> Val
	end.

-spec set(Key :: term(), Val :: term()) -> ok.
set(Key, Val) -> 
	mnesia:dirty_write(dcache, #dcache{key = Key, value = Val}).

-spec del(Key :: term()) -> ok.
del(Key) -> 
	mnesia:dirty_delete({dcache, Key}).
