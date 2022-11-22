

chancecard(tax, Player) :- kartupajak(Player).
chancecard(prize, Player) :- kartuhadiah(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player, CardInventory).
chancecard(gotojail, Player) :- pergikepenjara(Player).
chancecard(backthreestep, Player) :- mundurTigaLangkah(Player).
/*chancecard(angel, Player) :- */

kartupajak(P) :-
    moveToNearestTax(P),
    payTax(P).

kartuhadiah(P) :-
    random(M),
    plusMoney(P, M).

getkeluarpenjara(P, CardInventory) :-
    insertElmtLast(CardInventory, getout, A),
    CardInventory = A.

usekeluarpenjara(P, CardInventory) :-
    isPJailed(P, X),
    X =:= 1,
    deleteElmt(CardInventory, getout, A),
    getUnjailed(P),
    CardInventory = A.

pergikepenjara(P) :-
    getJailed(P),
    endTurn(P).

mundurTigaLangkah(P) :-
    movePlayerStep(P, -3).