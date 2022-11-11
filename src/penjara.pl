:- dynamic(isPJailed/2).
:- dynamic(turnInJail/2).

jailUpdater(P, NS):-
    retractall(isPJailed(P, _)),
    asserta(isPJailed(P, NS)).

turnInJailUpdater(P, NV):-
    retractall(turnInJail(P, _)),
    asserta(turnInJail(P, NV)).

addTurnInPenjara(P) :-
    turnInJail(P, X),
    NV is X + 1,
    turnInJailUpdater(P, NV).

resetTurnInJail(P) :-
    turnInJailUpdater(P, 0).

keluarPenjara(P) :-
    jailUpdater(P, 0).
    resetTurnInJail(P).

jailed(P) :- 
    jailUpdater(P, 1).




