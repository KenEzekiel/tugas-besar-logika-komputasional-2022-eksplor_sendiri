:- dynamic(turn/2).
:- dynamic(remainDice/2).
:- dynamic(firstTurn/2).

turn(v, 1).
turn(w, 0).

turnUpdater(P, NT):-
    retractall(turn(P, _)),
    asserta(turn(P, NT)).

remainDice(v, 1).
remainDice(w, 0).

remainDiceUpdater(P, NRD):-
    retractall(remainDice(P, _)),
    asserta(remainDice(P, NRD)).

firstTurn(v, 1).
firstTurn(w, 1).

firstTurnUpdater(P, NRD):-
    retractall(firstTurn(P, _)),
    asserta(firstTurn(P, NRD)).

endTurn :-
    turn(P, 1),
    retractall(playerState(P, _)),
    remainDice(P, 0),
    turn(v, T1),
    turn(w, T2),
    (T1 =:= 1 -> turnUpdater(v, 0), remainDiceUpdater(w, 1) ; turnUpdater(v, 1)),
    (T2 =:= 1 -> turnUpdater(w, 0), remainDiceUpdater(v, 1) ; turnUpdater(w, 1)).

decrementDice(P) :-
    remainDice(P, RD),
    NRD is RD - 1,
    remainDiceUpdater(P, NRD).

incrementDice(P):-
    remainDice(P, RD),
    NRD is RD + 1,
    remainDiceUpdater(P, NRD).

notFirstTurn(P),
    firstTurnUpdater(P, 0).