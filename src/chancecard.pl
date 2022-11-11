chancecard(tax, Player) :- pajak(Player).
chancecard(prize, Player) :- hadiah(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player).
chancecard(gotojail, Player) :- pergikepenjara(Player).

kartupajak(P) :-
    movePlayerTo(P, tx),
    bayarPajak(P).

kartuhadiah(P) :-
    random(M),
    plusMoney(P, M).

kartugetkeluarpenjara(P, CardInventory) :-
    insertElmtLast(CardInventory, kartukeluarpenjara, A),
    CardInventory = A.

kartukeluarpenjara(P, CardInventory) :-
    deleteElmt(CardInventory, kartukeluarpenjara, A),
    keluarPenjara(P),
    CardInventory = A.

kartukeluarpenjara(P) :-
    isPlayerinPenjara(P),
    format('Apakah Anda ingin keluar penjara? ~n'),
    inputJawaban(Jawaban),
    Jawaban =:= true,
    keluarPenjara(P).

kartupergiKePenjara(P) :-
    movePlayerTo(P, jl),
    endTurn(P).