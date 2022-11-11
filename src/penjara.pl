:- dynamic(isPlayerinPenjara/2).
:- dynamic(turnInPenjara/2).

penjaraStatusUpdate(P, NS):-
    retractall(isPlayerinPenjara(P, _)),
    asserta(isPlayerinPenjara(P, NS)).

turnInPenjaraStatusUpdate(P, NV):-
    retractall(turnInPenjara(P, _)),
    asserta(turnInPenjara(P, NV)).

addTurnInPenjara(P) :-
    turnInPenjara(P, X),
    NV is X + 1,
    turnInPenjaraStatusUpdate(P, NV).

resetTurnInPenjara(P) :-
    turnInPenjaraStatusUpdate(P, 0).

keluarPenjara(P) :-
    penjaraStatusUpdate(P, 0).
    resetTurnInPenjara(P).

masukPenjara(P) :- 
    penjaraStatusUpdate(P, 1).




