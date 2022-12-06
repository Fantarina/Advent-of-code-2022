-module(marker).
-export([main/1,main2/1]).
main(File) ->
    {ok,Io}= file:open(File,[read]),
    find(Io,[],0).

find(Io,[],Acc)->
    Next=io:get_chars(Io,"",1),
    find(Io,[Next],Acc+1);
find(Io,L,Acc) when length(L)==4 ->
    Next=io:get_chars(Io,"",1),
    case 4 == sets:size(sets:from_list(L)) of
        true-> Acc;
        false-> find(Io,[Next|lists:droplast(L)],Acc+1)
    end;
find(Io,L,Acc)->
    Next=io:get_chars(Io,"",1),
    case lists:member(Next,L) of
        false-> find(Io,[Next|L],Acc+1);
        true-> find(Io,[Next|lists:droplast(L)],Acc+1)
    end.

main2(File) ->
    {ok,Io}= file:open(File,[read]),
    find_start(Io,[],0).

find_start(Io,[],Acc)->
    Next=io:get_chars(Io,"",1),
    find_start(Io,[Next],Acc+1);
find_start(Io,L,Acc) when length(L)==14 ->
    Next=io:get_chars(Io,"",1),
    case 14 == sets:size(sets:from_list(L)) of
        true-> Acc;
        false-> find_start(Io,[Next|lists:droplast(L)],Acc+1)
    end;
find_start(Io,L,Acc)->
    Next=io:get_chars(Io,"",1),
    case lists:member(Next,L) of
        false-> find_start(Io,[Next|L],Acc+1);
        true-> find_start(Io,[Next|lists:droplast(L)],Acc+1)
    end.