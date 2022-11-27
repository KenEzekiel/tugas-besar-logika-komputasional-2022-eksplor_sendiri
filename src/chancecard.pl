choice(1, tax).
choice(2, prize).
choice(3, zonk).
choice(4, getout).
choice(5, gotojail).
choice(6, backthreestep).
choice(7, threestep).
choice(8, birthday).

/* Ini fungsi yang di call saat di petak chancecard */
drawchancecard(P) :-
    randomize,
    get_seed(M),
    N is M mod 10,
    choice(N, Card),
    chancecard(Card, P).



chancecard(tax, Player) :- kartupajak(Player).
chancecard(prize, Player) :- kartuhadiah(Player).
chancecard(zonk, Player) :- kartuzonk(Player).
chancecard(getout, Player) :- getkeluarpenjara(Player, _CardInventory).
chancecard(gotojail, Player) :- pergikepenjara(Player).
chancecard(backthreestep, Player) :- mundurTigaLangkah(Player).
chancecard(threestep, Player) :- majuTigaLangkah(Player).
chancecard(birthday, Player) :- ulangTahun(Player).
/*chancecard(angel, Player) :- */


kartupajak(P) :-
    moveToNearestTax(P),
    write('\nYanFei menyadari kamu lupa membayar pajak bulan kemarin, kamu harus pergi ke rumah YanFei lalu membayar pajak.\n'),
    payTax(P).

kartuhadiah(P) :-
    randomize,
    get_seed(M),
    A is M mod 1000,
    format('~nAnda diangkat menjadi anak asuh Ningguang! Uang Anda bertambah sebesar : ~w~n', [A]),
    addBalance(P, A).

kartuzonk(P) :-
    randomize,
    get_seed(M),
    A is M mod 1000,
    B is A * (-1),
    format('~nFatui datang ke safehousemu! Kamu kehilangan uang sebesar : ~w~n', [A]),
    addBalance(P, B).

getkeluarpenjara(_, CardInventory) :-
    insertElmtLast(CardInventory, getout, A),
    CardInventory = A,
    write('\nKamu diperbolehkan memanggil Xiao untuk keluar penjara,gunakan commang xiaoHelp untuk menggunakan kartu ini\n').

/* Ini bisa di call oleh user */
xiaoHelp(P) :-
    cardInventory(P, Inventory),
    usekeluarpenjara(P, Inventory).

usekeluarpenjara(P, CardInventory) :-
    isPJailed(P, X), 
    X =:= 1, !,
    deleteElmt(CardInventory, getout, A),
    getUnjailed(P),
    write('\nKamu memanggil Xiao! Kamu dapat keluar dari penjara.\n'),
    CardInventory = A.

pergikepenjara(P) :-
    write('\nANGKAT TANGAN!! Anda masuk ke penjara!\n'),
    getJailed(P),
    endTurn(P).

mundurTigaLangkah(P) :-
    write('\nKamu kejatuhan tombak Xiao! Mundur 3 langkah, 1 2 3, DOR!\n'),
    movePlayerStep(P, -3).

majuTigaLangkah(P) :-
    write('\nKamu didorong ushi, maju 3 langkah\n'),
    movePlayerStep(P, 3).

ulangTahun(P) :-
    write('\nOTANJOUBI OMEDETOU! Semua player membayar anda sebesar 500, yang tidak bayar akan dipukul oleh Itto\n'),
    bayarKeP(P, 500).

bayarKeP(P, Amount) :-
    player(X),
    X \= P,
    addBalance(P, 500),
    subtractBalance(X, Amount).