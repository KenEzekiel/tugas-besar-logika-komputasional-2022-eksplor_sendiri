choice(0, childe).
choice(1, tax).
choice(2, prize).
choice(3, zonk).
choice(4, getout).
choice(5, gotojail).
choice(6, backthreestep).
choice(7, threestep).
choice(8, birthday).
choice(9, zonkyanfei).
choice(10, meteor).
choice(11, pass).
choice(12, paimon).
choice(13, brokenteleport).
choice(14, teleportcard).
choice(15, sedekahcard).
choice(16, bribezhonglicard).

/* Ini fungsi yang di call saat di petak chancecard */
drawchancecard(P) :-
    randomize,
    get_seed(M),
    N is M mod 17,
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
chancecard(zonkyanfei, Player) :- kartuyanfei(Player).
chancecard(meteor, _) :- meteorZhongli.
chancecard(pass, Player) :- passgo(Player).
chancecard(paimon, Player) :- kartupaimon(Player).
chancecard(childe, Player) :- kartuchilde(Player).
chancecard(brokenteleport, Player) :- brokenteleport(Player).
chancecard(teleportcard, Player) :- teleport(Player).
chancecard(sedekahcard, Player) :- sedekah(Player). 
chancecard(bribezhonglicard, Player) :- getbribeZhongli(Player).
/*chancecard(angel, Player) :- */


kartupajak(P) :-
    moveToNearestTax(P),
    write('\nYanFei menyadari kamu lupa membayar pajak bulan kemarin, kamu harus pergi ke rumah YanFei lalu membayar pajak.\n'),
    payTax(P).

kartuhadiah(P) :-
    randomize,
    get_seed(M),
    A is M mod 2000,
    format('~nAnda diangkat menjadi anak asuh Ningguang! Mora Anda bertambah sebesar : ~w~n', [A]),
    addBalance(P, A).

kartuzonk(P) :-
    randomize,
    get_seed(M),
    A is M mod 2000,
    B is A * (-1),
    format('~nFatui datang ke safehousemu! Kamu kehilangan Mora sebesar : ~w~n', [A]),
    addBalance(P, B).

getkeluarpenjara(P) :-
    insertToInventory(P, getout),   
    write('\nKamu diperbolehkan memanggil Xiao untuk keluar penjara,gunakan commang xiaoHelp untuk menggunakan kartu ini\n'), !.

/* Ini bisa di call oleh user */
xiaoHelp :-
    turn(P, 1),
    cardInventory(P, Inventory),
    isElmt(Inventory, getout, Ans),
    Ans =:= 1, !,
    usekeluarpenjara(P, Inventory).

usekeluarpenjara(P, CardInventory) :-
    isPJailed(P, X), 
    X =:= 1, !,
    deleteFromInventory(P, getout),
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
    write('\nOTANJOUBI OMEDETOU! Semua player membayar Anda sebesar 500, yang tidak bayar akan dipukul oleh Itto\n'),
    bayarKeP(P, 500).

bayarKeP(P, Amount) :-
    player(X),
    X \= P,
    addBalance(P, 500),
    subtractBalance(X, Amount).

kartuyanfei(P) :-
    randomize,
    get_seed(M),
    A is M mod 1000,
    B is A * (-1),
    format('~nYanFei menyadari Anda melakukan penggelapan pajak! Anda didenda sebesar : ~w~n', [A]),
    addBalance(P, B).

meteorZhongli :-
    randomize,
    get_seed(M),
    boardAssetLength(Length),
    A is M mod Length,
    boardAsset(Board),
    getElmt(Board, A, Tile),
    tileAsset(Tile, State, Player),
    format('~nTile ~w terkena meteor zhongli! semua bangunan di tile tersebut kandas :(~n', [Tile]),
    updateKandas(Tile, State, Player).

updateKandas(Tile, -2, Player) :-
    tileAssetUpdater(Tile, -2, Player), !.

updateKandas(Tile, -1, Player) :-
    tileAssetUpdater(Tile, -1, Player), !.

updateKandas(Tile, State, Player) :-
    tileAssetUpdater(Tile, 0, Player), !.

passgo(Player) :-
    addBalance(Player, 5000),
    movePlayerTo(Player, go).

kartupaimon(P) :-
    randomize,
    get_seed(M),
    A is M mod 500,
    B is A * (-1),
    format('~nPaimon kabur! Dia bermain dan menghabiskan Mora Anda sebesar : ~w~n', [A]),
    addBalance(P, B).

kartuchilde(P) :-
    randomize,
    get_seed(M),
    A is M mod 800,
    format('~nAnda diajak jalan-jalan oleh Childe! Anda diberi Mora sebesar : ~w~n', [A]),
    addBalance(P, A).

brokenTeleportWaypoint(P) :-
    randomize,
    get_seed(M),
    boardLength(Length),
    board(Board),
    A is M mod Length,
    getElmt(Board, A, Tile),
    format('~nTeleport waypoint yang Anda gunakan rusak! Anda diteleport ke tile ~w~n', [Tile]),
    movePlayerTo(P, Tile).

teleport(P) :-
    /* Teleport kalau teleport nya lewatin GO ga dapet uang ya! */
    write('\nMasukkan indeks teleport (input diakhiri titik) : '),
    read(Index),
    boardLength(Length),
    board(Board),
    Idx is Index mod Length,
    getElmt(Board, Idx, Tile),
    format('~nWhoosh! Anda diteleport ke tile ~w~n', [Tile]),
    write('\nNote : teleport tidak mendapatkan Mora! Jika indeks lebih dari panjang board, akan di mod dengan panjang board! \n'),
    movePlayerTo(P, Tile).

sedekah(P) :-
    balanceMin(PMin),
    PMin == P,
    write('\nAnda diminta bersedekah oleh Barbara, tapi Anda yang termiskin, jadi Barbara kasihan dan memberimu sedekah 500 Mora\n'),
    addBalance(P, 500), !.

sedekah(P) :-
    balanceMin(PMin),
    format('~nAnda diminta bersedekah oleh Barbara, Anda bersedekah ke player ~w sebesar 500~n', [PMin]),
    addBalance(PMin, 500),
    addBalance(P, -500), !.


balanceMin(PlayerMin) :-
  balance(PlayerMin, Bal),
  \+ (balance(Other, BalO), Other \= PlayerMin, Bal > BalO), !.

getbribeZhongli(P) :-
    write('\nKamu mendapatkan 5 toren osmanthus wine!\nkamu bisa menggunakan ini ditambah dengan 7000 Mora untuk menyuap Zhongli mengirimkan meteor dengan command suapZhongli\n'),
    insertToInventory(P, bribezhonglicard), !.

suapZhongli :-
    turn(P, 1),
    cardInventory(P, Inventory),
    isElmt(Inventory, bribezhonglicard, Ans),
    Ans =:= 1, !,
    deleteFromInventory(Player, bribezhonglicard),
    balance(P, Bal),
    Bal >= 7000, !,
    write('\nKamu membayar 7000 Mora\n'),
    addBalance(P, -7000),
    write('\nMasukkan indeks kota yang ingin dijatuhi meteor (diakhiri titik) : '),
    read(Index),
    boardLength(Length),
    board(Board),
    Idx is Index mod Length,
    getElmt(Board, Idx, Tile),
    format('~nTile ~w terkena meteor zhongli! semua bangunan di tile tersebut kandas :(~n', [Tile]),
    updateKandas(Tile, State, Player).
