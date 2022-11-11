:- dynamic(pPos/2).

pPos(p1, 0).
pPos(p2, 0).

nthTile([H|T], 0, H), !.
nthTile([H|T], I):-
    I > 0,
    elmtIMap(T, I), !.

pPosUpdater(P, NS):-
    retractall(pPos(P, _)),
    asserta(pPos(P, NS)).

rollDice(Res, Double):-
    random(1, 6, Res1),
    random(1, 6, Res2),
    Res is Res1 + Res2,
    (Res1 \== Res2 -> Double is 0 ; Double is 1).

move(P, DestinationIndex):- 
    turn(P, T),
    (T =:= 1 ->
    pPosUpdater(P, DestinationIndex) ; fail).

    


