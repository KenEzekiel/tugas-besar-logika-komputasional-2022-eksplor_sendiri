choice(1, tax).
choice(2, prize).
choice(3, zonk).
choice(4, getout).
choice(5, gotojail).
choice(6, backthreestep).

drawchancecard(P) :-
    randomize,
    get_seed(M),
    N is M mod 10
    choice(N, Card),
    chancecard(Card, P).



chancecard(tax, Player) :- kartupajak(Player).
chancecard(prize, Player) :- kartuhadiah(Player).
chancecard(zonk, Player) :- kartuzonk(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player, CardInventory).
chancecard(gotojail, Player) :- pergikepenjara(Player).
chancecard(backthreestep, Player) :- mundurTigaLangkah(Player).
/*chancecard(angel, Player) :- */


kartupajak(P) :-
    moveToNearestTax(P),
    payTax(P).

kartuhadiah(P) :-
    randomize,
    get_seed(M),
    A is M mod 1000,
    format('~nSelamat! Anda mendapatkan hadiah sebesar : ~w~n', [A]),
    addBalance(P, A).

kartuzonk(P) :-
    randomize,
    get_seed(M),
    A is M mod 1000,
    B is A * (-1),
    format('~nAnda tipes! Anda harus membayar biaya rumah sakit sebesar : ~w~n', [A]),
    addBalance(P, B).

getkeluarpenjara(P, CardInventory) :-
    insertElmtLast(CardInventory, getout, A),
    CardInventory = A.

/* Ini bisa di call oleh user */
usekeluarpenjara(P, CardInventory) :-
    isPJailed(P, X),
    X =:= 1,
    deleteElmt(CardInventory, getout, A),
    getUnjailed(P),
    CardInventory = A.

pergikepenjara(P) :-
    write('\nANGKAT TANGAN! Anda masuk ke penjara!\n'),
    getJailed(P),
    endTurn(P).

mundurTigaLangkah(P) :-
    movePlayerStep(P, -3).