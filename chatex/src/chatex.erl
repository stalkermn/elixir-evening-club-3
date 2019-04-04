-module(chatex).

-export([
	join_group/1,
	register/1,
	send_message/2,
	send_group_message/2
]).


join_group(GroupName) -> 
	syn:join(GroupName, self()).

register(Name) -> 
	syn:register(Name, self()).

send_message(Name, Message) -> 
	case syn:find_by_key(Name) of
		undefined -> 
			not_found;
		Pid -> 
			Pid ! Message
	end.

send_group_message(GroupName, Message) -> 
	syn:publish(GroupName, Message).
	