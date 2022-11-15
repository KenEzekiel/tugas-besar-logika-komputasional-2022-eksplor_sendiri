:- dynamic(tileAsset/2).
:- dynamic(tileInventory/2).


tileInventory(v, []).
tileInventory(w, []).
% Status aset di tiap tile
% -2 tile tidak bertuan
% -1 tile sedang di-mortgage
% 0 tile tidak ada properti apapun
% 1-3 tile punya jumlah rumah sejumlah itu
% 4 tile punya landmark
tileAsset(a1,-2).
tileAsset(a2,-2).
tileAsset(a3,-2).
tileAsset(b1,-2).
tileAsset(b2,-2).
tileAsset(b3,-2).
tileAsset(c1,-2).
tileAsset(c2,-2).
tileAsset(c3,-2).
tileAsset(d1,-2).
tileAsset(d2,-2).
tileAsset(d3,-2).
tileAsset(e1,-2).
tileAsset(e2,-2).
tileAsset(e3,-2).
tileAsset(f1,-2).
tileAsset(f2,-2).
tileAsset(f3,-2).
tileAsset(g1,-2).
tileAsset(g2,-2).
tileAsset(g3,-2).
tileAsset(h1,-2).
tileAsset(h2,-2).

colorGroup(brown, [a1, a2, a3]).
colorGroup(cyan, [b1, b2, b3]).
colorGroup(magenta, [c1, c2, c3]).
colorGroup(orange, [d1, d2, d3]).
colorGroup(red, [e1, e2, e3]).
colorGroup(yellow, [f1, f2, f3]).
colorGroup(green, [g1, g2, g3]).
colorGroup(blue, [h1, h2]).

tileAssetUpdater(Tile, NS):-
    retractall(tileAsset(Tile, _)),
    asserta(tileAsset(Tile, NS)).

tileInventoryUpdater(P, NewInventory):-
    retractall(tileInventory(Tile, _)),
    asserta(tileInventory(Tile, NewInventory)).

inventoryAppender(P, NewTile):-
    tileInventory(P, Inventory),
    insertElmtLast(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

inventoryDeleter(P, NI):-
    tileInventory(P, Inventory),
    deleteElmt(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

% Groupname adalah nama dari grup warna Tile
colorGroupOfTile(Tile, GroupName, Res) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList, Res), !.

% TileList adalah list tile dari grup warna Tile
tileListOfTile(Tile, TileList, Res) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList, Res), !.

% Res adalah apakah P memiliki set komplit dari grup warna Tile
completeSet(P, Tile, Res):-
    colorGroupOfTile(Tile, GroupName, 1),
    colorGroup(GroupName, TileList),
    tileInventory(P, Inventory),
    (\+ (isElmt(Tile_C, TileList, 1), isElmt(Tile_C, Inventory, 0)) -> Res is 1; Res is 0).

tileOwner(Tile, P) :-
    tileInventory(P, Inventory),
    isElmt(Inventory, Tile, 1).

% Cek dasar apakah pemain bisa me-mortgage atau menebus mortgage tile
canRedeemBasicCheck(P, Tile, Res) :-
    (turn(P, 1),
    tileInventory(P, Inventory),
    isElmt(Tile,Inventory, 1)) -> Res is 1 ; Res is 0, !.

% Cek dasar apakah pemain bisa membeli properti di sebuah tile
canBuyBasicCheck(P, Tile, Res):-
    (turn(P, 1),
    (pTile(P, Tile) ; pTile(P, go)),
    tileInventory(P, Inventory),
    isElmt(Tile,Inventory, 1), completeSet(P, Tile, 1)) -> Res is 1 ; Res is 0, !.

% Equality adalah apakah properti dari sebuah group tile merata
equalityCheck(Tile, Equality) :-
    tileAsset(Tile, TileAsset),
    tileListOfTile(Tile, TileList),
    \+ (isElmt(X, TileList, 1), tileAsset(X, XAsset), X < TileAsset).

% Membeli Tile
buyTile(P, Tile):-
    tileInventory(P, Inventory),
    \+ (isElmt(Tile, Inventory, 1)),
    balance(P, Bal),
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price)
    Bal >= Price,
    subtractBalance(P, Price),
    inventoryAppender(P, Tile).
    tileAssetUpdater(Tile, 0).

% Menebus tile yang sedang di-mortgage
buyAset(P, Tile, m):-
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= -1,
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA).

% Membeli rumah pada sebuah tile
buyAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    balance(P, Bal),
    tileAsset(Tile, TileAsset),
    TileAsset < 3, TileAsset >= 0,
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA).

% Membeli hotel pada sebuah tile
buyAset(P, Tile, l):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 3,
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    NTA is TileAsset + 1.
    tileAssetUpdater(Tile, NTA).

% Meng-mortgage tile
sellAset(P, Tile, m):- 
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 0,
    NTA is TileAsset - 1,
    propertyPrices(Tile, Prices),
    getElmt(Prices, 0, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    tileAssetUpdater(Tile, NTA).

% Membeli rumah pada sebuah tile
sellAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset < 4, TileAsset > 0,
    propertyPrices(Tile, Prices),
    getElmt(Prices, TileAsset, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

% Menjual hotel pada sebuah tile
sellAset(P, Tile, l):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 4,
    propertyPrices(Tile, Prices),
    getElmt(Prices, TileAsset, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    NTA is TileAsset - 1.
    tileAssetUpdater(Tile, NTA).

    