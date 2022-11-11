:- dynamic(playerPosition/2).

resetPlayerPosition :-
    playerPosition(p1, 0).
    playerPosition(p2, 0).

nthTile([H|T], 0, H), !.
nthTile([H|T], I):-
    I > 0,
    elmtIMap(T, I), !.

pPositionStatusUpdate(P, NS):-
    retractall(playerPosition(P, _)),
    asserta(playerPosition(P, NS)).

rollDice(Res, Double):-
    random(1, 6, Res1),
    random(1, 6, Res2),
    Res is Res1 + Res2,
    (Res1 \== Res2 -> Double is 0 ; Double is 1).

move(P, DestinationIndex):- 
    pPositionStatusUpdate(P, NS).

    


