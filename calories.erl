%Day1
-module(calories).
-export([main/1,main2/1]).


main(File)->
    {ok,IO}= file:open(File,[read]),
    L=readcum(IO,[],0),
    lists:max(L).


readcum(Io,List,Acc)->
    case file:read_line(Io) of
        eof-> List;
        {ok,"\n"}->
            New=[Acc|List],
            readcum(Io,New,0);
        {ok,Number}->
            T= list_to_integer(string:trim(Number)),
            readcum(Io,List,Acc+T)
        end.

main2(File)->
    {ok,IO}= file:open(File,[read]),
    L=readcum(IO,[],0),
    [O,Tw,Th|_]=lists:reverse(lists:sort(L)),
    O+Tw+Th.