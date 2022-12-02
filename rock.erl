-module(rock).
-export([main/1,main2/1]).
main(File)->
    {ok,IO}= file:open(File,[read]),
    score(IO,0).

score(Io,Acc)->
    case file:read_line(Io) of
        eof->Acc;
        {ok,String}->
            [Opp,32,Me]= string:trim(String),            
            score(Io,Acc+process({Opp,conv(Me)})) end.

process({Opp,Opp})->
    3+ value(Opp);
process({$A,$B})->
    6+value($B);
process({$B,$C})->
    6+value($C);
process({$C,$A})->
    6+value($A);
process({_,Me})->
    value(Me).

value($A)->
    1;
value($B)->
    2;
value($C)->
    3.

conv($X)->
    $A;
conv($Y)->
    $B;
conv($Z)->
    $C.

main2(File)->
    {ok,IO}= file:open(File,[read]),
    score2(IO,0).

score2(Io,Acc)->
    case file:read_line(Io) of
        eof->Acc;
        {ok,String}->
            [Opp,32,Me]= string:trim(String),            
            case Me of
                $X-> score2(Io,Acc+process({Opp,lose(Opp)}));
                $Y-> score2(Io,Acc+process({Opp,Opp}));
                $Z-> score2(Io,Acc+process({Opp,win(Opp)}))  end end.


lose($A)->$C;
lose($B)->$A;
lose($C)->$B.

win($A)->$B;
win($B)-> $C;
win($C)-> $A.