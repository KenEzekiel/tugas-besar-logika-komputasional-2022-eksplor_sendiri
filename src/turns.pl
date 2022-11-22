:- dynamic(turn/2).

turn(v, 1).
turn(w, 0).

turnUpdater(P, NT):-
    retractall(turn(P, _)),
    asserta(turn(P, NT)).

endTurn :-
    turn(v, T1),
    turn(w, T2),
    (T1 =:= 1 -> turnUpdater(v, 0) ; turnUpdater(w, 1)),
    (T2 =:= 1 -> turnUpdater(w, 0) ; turnUpdater(v, 1)).


