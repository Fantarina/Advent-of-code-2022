%Day 3
-module(rucksack).
-export([main/1,main2/1]).

priority(A) when A=<90 ->
    A-38;
priority(A)->
    A-96.


main(File)->
    {ok,IO}= file:open(File,[read]),
    sack(IO,0).


sack(Io,Acc)->
    case file:read_line(Io) of
        eof-> Acc;
        {ok,L}->
            Sack=string:trim(L),
            Priority=find_duplicate(Sack),
            sack(Io,Acc+Priority)
    end.

find_duplicate(Sack)->
    Part1= lists:sublist(Sack,length(Sack) div 2), 
    Part2= lists:sublist(Sack,length(Sack) div 2 +1,length(Sack) div 2 +1),
    Set1= sets:from_list(Part1),
    Set2= sets:from_list(Part2),
    [Elmt]=sets:to_list(sets:intersection(Set1,Set2)),
    priority(Elmt).


main2(File)->
    {ok,IO}= file:open(File,[read]),
    sack2(IO,0,[]).


sack2(Io,Acc,Gather) when length(Gather)< 3->
    case file:read_line(Io) of
        eof-> Acc;
        {ok,L}->
            Sack=string:trim(L),            
            sack2(Io,Acc,[Sack|Gather])
    end;
sack2(Io,Acc,Gather)->
    Res=find(Gather),
    sack2(Io,Acc+Res,[]).



find(Badge)->
    Listofsets=[sets:from_list(X)|| X<-Badge],
    B= sets:intersection(Listofsets),
    [Res]= sets:to_list(B),
    priority(Res).