:- dynamic(isPJailed/2).
:- dynamic(turnInJail/2).

isPJailed(v, 0).
isPJailed(w, 0).

jailUpdater(P, NS):-
    retractall(isPJailed(P, _)),
    asserta(isPJailed(P, NS)).

turnInJailUpdater(P, NV):-
    retractall(turnInJail(P, _)),
    asserta(turnInJail(P, NV)).

addTurnInJail(P) :-
    turnInJail(P, X),
    NV is X + 1,
    turnInJailUpdater(P, NV).

resetTurnInJail(P) :-
    turnInJailUpdater(P, 0).

getUnjailed(P) :-
    jailUpdater(P, 0).
    resetTurnInJail(P).

getJailed(P) :- 
    jailUpdater(P, 1), !.




