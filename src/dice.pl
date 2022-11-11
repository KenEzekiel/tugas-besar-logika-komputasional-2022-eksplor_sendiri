:- dynamic(pPos/2).
:- dynamic(pTile/2).

pPos(p1, 0).
pPos(p2, 0).

nthTile([H|T], 0, H):- !.
nthTile([H|T], I, Tile):-
    I > 0,
    I1 is I-1,
    nthTile(T, I1, Tile), !.

pTile(P, Tile) :-
    pPos(P, Index),
    board(B),
    nthTile(B, Index, Tile).


pPosUpdater(P, NS):-
    retractall(pPos(P, _)),
    asserta(pPos(P, NS)).

rollDice(Res, Double):-
    random(1, 6, Res1),
    random(1, 6, Res2),
    Res is Res1 + Res2,
    (Res1 \== Res2 -> Double is 0 ; Double is 1).

moveToTarget(P, DestinationIndex):- 
    turn(P, T),
    isPJailed(P, J),
    ((T =:= 1, J =:= 0 )->
    pPosUpdater(P, DestinationIndex) ; fail).

moveForward(P, Increment):- 
    turn(P, T),
    isPJailed(P, J),
    pPos(P, Loc),
    boardLength(L),
    Destination is ((Loc + Increment) mod L),
    ((T =:= 1, J =:= 0 )->
    pPosUpdater(P, Destination) ; fail).

    


