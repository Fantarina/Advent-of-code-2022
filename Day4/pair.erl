-module(pair).
-export([main/1,main2/1]).

main(Input)->
    {ok,Io}= file:open(Input,[read]),
    count(Io,0).

main2(Input)->
    {ok,Io}= file:open(Input,[read]),
    count2(Io,0).

count(Io,Acc)->
    case file:read_line(Io) of
        eof-> Acc;
        {ok,L}-> 
            Pair=string:trim(L),
            [Range1,Range2]= string:split(Pair,","),
            P1=string:split(Range1,"-"),
            P2=string:split(Range2,"-"),

            Add=does_contain(pair_to_integer(P1),pair_to_integer(P2)),
            count(Io,Acc+Add)
        end.

count2(Io,Acc)->
    case file:read_line(Io) of
        eof-> Acc;
        {ok,L}-> 
            Pair=string:trim(L),
            [Range1,Range2]= string:split(Pair,","),
            P1=string:split(Range1,"-"),
            P2=string:split(Range2,"-"),

            Add=does_overlap(pair_to_integer(P1),pair_to_integer(P2)),
            count2(Io,Acc+Add)
        end.

does_contain([Start1,Stop1],[Start2,Stop2]) when (Start1 =< Start2 andalso Stop1 >=Stop2) or (Start2 =< Start1 andalso Stop2 >= Stop1)->
    1;
does_contain(_,_) ->
    0.

does_overlap([Start1,Stop1],[Start2,Stop2]) when not(Stop1<Start2 orelse Stop2<Start1)->
    1;
does_overlap(_,_)->
    0.
    
pair_to_integer(P)->
    [list_to_integer(X)||X<-P].