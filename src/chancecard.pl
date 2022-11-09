

chancecard(tax, Player) :- pajak(Player).
chancecard(prize, Player) :- hadiah(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player).
chancecard(gotojail, Player) :- pergikepenjara(Player).

pajak(P) :-
    movePlayerTo(P, tx),
    bayarPajak(P).

hadiah(P) :-
    random(M),
    plusMoney(P, M).

getkeluarpenjara(P, CardInventory) :-
    insertElmtLast(CardInventory, kartukeluarpenjara, A),
    CardInventory = A.

usekeluarpenjara(P, CardInventory) :-
    deleteElmt(CardInventory, kartukeluarpenjara, A),
    keluarpenjara(P),
    CardInventory = A.

keluarpenjara(P) :-
    isPlayerinPenjara(P),
    format('Apakah Anda ingin keluar penjara? ~n'),
    inputJawaban(Jawaban),
    Jawaban =:= true,
    fungsiKeluarPenjara(P).

pergikepenjara(P) :-
    movePlayerTo(P, jl),
    endTurn(P).