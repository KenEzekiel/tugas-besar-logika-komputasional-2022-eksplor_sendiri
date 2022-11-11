:- dynamic(turn/2).

turn(p1, 1).
turn(p2, 0).

turnUpdater(P, NT):-
    retractall(turn(P, _)),
    asserta(turn(P, NT)).

changeTurn :-
    turn(p1, T1),
    turn(p2, T2),
    (T1 =:= 1 -> turnUpdater(p1, 0) ; turnUpdater(p1, 1)),
    (T2 =:= 1 -> turnUpdater(p2, 0) ; turnUpdater(p2, 1)).


