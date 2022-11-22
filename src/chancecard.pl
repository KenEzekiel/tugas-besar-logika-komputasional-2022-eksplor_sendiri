

chancecard(tax, Player) :- kartupajak(Player).
chancecard(prize, Player) :- kartuhadiah(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player, CardInventory).
chancecard(gotojail, Player) :- pergikepenjara(Player).
chancecard(angel, Player) :-

kartupajak(P) :-
    movePlayerTo(P, tx),
    payTax(P).

kartuhadiah(P) :-
    random(M),
    plusMoney(P, M).

getkeluarpenjara(P, CardInventory) :-
    insertElmtLast(CardInventory, kartukeluarpenjara, A),
    CardInventory = A.

usekeluarpenjara(P, CardInventory) :-
    deleteElmt(CardInventory, kartukeluarpenjara, A),
    isPJailed(P, X),
    X =:= 1,
    getUnjailed(P),
    CardInventory = A.
    

pergikepenjara(P) :-
    getJailed(P),
    endTurn(P).