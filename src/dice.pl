:- dynamic(doubleAmount/2).

doubleAmountUpdater(P, NS):-
    retractall(doubleAmount(P, _)),
    asserta(doubleAmount(P, NS)).

incrementDoubleAmount(P) :-
    doubleAmount(P, DA),
    NDA is DA + 1,
    doubleAmountUpdater(P, NDA).

resetDoubleAmount(P) :-
    doubleAmountUpdater(P, 0).

rollDice(Res1, Res2, Double):-
    random(1, 6, Res1),
    random(1, 6, Res2),
    write('Dadu 1: '),
    write(Res1), write('.'), nl,
    write('Dadu 2: '),
    write(Res2), write('.'), nl,
    (Res1 \== Res2 -> Double is 0 ; Double is 1).

doubleAmount(v, 0).
doubleAmount(w, 0).

throwDiceCheck(P, CanThrow):-
    turn(P, 1),
    remainDice(P, RD),
    (RD > 0 -> CanThrow is 1 ; write('Anda tidak punya kesempatan roll dice lagi. Segera end turn.'), CanThrow is 0).

throwDice :-
    throwDiceCheck(P, 1), 
    throwDiceW(Double),
    (Double =:= 1 -> doNothing; decrementDice(P)),
    location(P, Pos),
    ((Pos =:= tx1 ; Pos =:= tx2) -> payTax(P) ; ((Pos \== jl, Pos \== go, Pos \== wt, Pos \== fp) -> payRent(P, Pos) ; doNothing)), !.

% Karena setelah lempar dadu pemain masih bisa jual aset, masih harus bayar sewa, dll, logika untuk pergantian turn bukan di sini, tapi di throwDice. 
% Logika untuk masuk penjara setelah 3 kali double ada di sini
% Ini wrapper.
throwDiceW(Double) :- 
    turn(PMoving, 1),
    write('Sekarang adalah giliran pemain '),
    write(PMoving), write('.'), nl,
    (isPJailed(PMoving, 1) -> throwDiceJail(P, Double) ; throwDiceFree(P, Double)),
    (\+ playerState(P, diceThrown) -> stateChanger(P, diceThrown) ; doNothing),
    !.

throwDiceJail(P, Double) :-
    incrementTurnInJail(P),
    rollDice(_, _, Double),
    turnInJail(P, TJ),
    (Double =:= 1 -> getUnjailed(P), write('Selamat, anda telah bebas dari penjara') ; (TJ =:= 3 -> write('Telah ada di penjara dalam 3 turn, anda otomatis bebas') ; write('Gagal mendapat double, masih dipenjara'))).


throwDiceFree(P, Double) :-
    rollDice(Res1, Res2, Double),
    Res is Res1 + Res2,
    (Double =:= 1 -> write('Double! '), incrementDoubleAmount(P) ; true),
    (doubleAmount(P, 3) -> (getJailed(P), resetDoubleAmount(P)), write('Anda masuk penjara karena mendapat Double 3 kali berturut-turut') ; (
    write('Anda maju sebanyak '), write(Res), write(' langkah.'), nl, movePlayerStep(P, Res))), !.
    


