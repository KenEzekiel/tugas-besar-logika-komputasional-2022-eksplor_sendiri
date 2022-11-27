:- dynamic(tileAsset/3).
:- dynamic(tileInventory/2).


tileInventory(v, []).
tileInventory(w, []).
% Status aset di tiap tile
% -2 : tile tidak bertuan
% -1 : tile sedang di-mortgage
% 0 : tile tidak ada properti apapun tapi ada yang punya
% 1-3 : tile punya bangunan sejumlah itu
% 4 : tile punya landmark
tileAsset(a1,0, v).
tileAsset(a2,-2, none).
tileAsset(a3,-2, none).
tileAsset(b1, 3, v).
tileAsset(b2,-2, none).
tileAsset(b3,-2, none).
tileAsset(c1,-2, none).
tileAsset(c2,-2, none).
tileAsset(c3,-2, none).
tileAsset(d1,-1, v).
tileAsset(d2,0, w).
tileAsset(d3,-2, none).
tileAsset(e1,-2, none).
tileAsset(e2,-2, none).
tileAsset(e3,-2, none).
tileAsset(f1, 1, w).
tileAsset(f2,-2, none).
tileAsset(f3,-2, none).
tileAsset(g1,-2, none).
tileAsset(g2,-2, none).
tileAsset(g3,-2, none).
tileAsset(h1, 4, w).
tileAsset(h2,-2, none).

colorGroup(brown, [a1, a2, a3]).
colorGroup(cyan, [b1, b2, b3]).
colorGroup(magenta, [c1, c2, c3]).
colorGroup(orange, [d1, d2, d3]).
colorGroup(red, [e1, e2, e3]).
colorGroup(yellow, [f1, f2, f3]).
colorGroup(green, [g1, g2, g3]).
colorGroup(blue, [h1, h2]).

tileAssetUpdater(Tile, NS, NO):-
    retractall(tileAsset(Tile, _, _)),
    asserta(tileAsset(Tile, NS, NO)).

tileInventoryUpdater(P, NewInventory):-
    retractall(tileInventory(P, _)),
    asserta(tileInventory(P, NewInventory)).

inventoryAppender(P, NewTile):-
    tileInventory(P, Inventory),
    insertElmtLast(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

inventoryDeleter(P, NewTile):-
    tileInventory(P, Inventory),
    deleteElmt(Inventory, NewTile, NewInventory),
    tileInventoryUpdater(P, NewInventory).

% Groupname adalah nama dari grup warna Tile
colorGroupOfTile(Tile, GroupName, Res) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList, Res), !.

% TileList adalah list tile dari grup warna Tile
tileListOfTile(Tile, TileList, Res) :-
    colorGroup(_, TileList),
    isElmt(Tile, TileList, Res), !.

% Res adalah apakah P memiliki set komplit dari grup warna Tile
completeSet(P, Tile, Res):-
    colorGroupOfTile(Tile, GroupName, 1),
    colorGroup(GroupName, TileList),
    tileInventory(P, Inventory),
    (\+ (isElmt(Tile_C, TileList, 1), isElmt(Tile_C, Inventory, 0)) -> Res is 1; Res is 0).

% Menghasilkan status aset yang sesuai
assetStatusWriter(PropStat) :-
    PropStat >= 1, PropStat =< 3,
    format('Bangunan ~w', [PropStat]), !.

assetStatusWriter(-2) :-
    write('Tanah tak bertuan'), !.

assetStatusWriter(-1) :-
    write('Hipotek'), !.

assetStatusWriter(0) :-
    write('Tanah'), !.

assetStatusWriter(4) :-
    write('Landmark'), !.

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

% Take over tile orang
acquireTile(P, Tile):-
    tileAsset(Tile, Level, Owner),
    ((Owner =\= none, Level =\= 4) -> 
    (
        balance(P, Bal),
        tileAsset(Tile, TileAsset, _),
        propertyPrices(Tile, Prices),
        getElmt(TileAsset, Prices, Price),
        Bal >= 2 * Price,
        AP is 2 * Price,
        subtractBalance(P, AP),
        inventoryAppender(P, Tile),
        tileAssetUpdater(Tile, 0, P)
    ) ; doNothing).

% Membeli Tile
buyTile(P, Tile):-
    tileInventory(P, Inventory),
    \+ (isElmt(Tile, Inventory, 1)),
    balance(P, Bal),
    tileAsset(Tile, TileAsset, _),
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    inventoryAppender(P, Tile),
    tileAssetUpdater(Tile, 0, P).

% Membeli Tile
buyTile(P, Tile):-
    tileInventory(P, Inventory),
    \+ (isElmt(Tile, Inventory, 1)),
    balance(P, Bal),
    tileAsset(Tile, TileAsset, _),
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    inventoryAppender(P, Tile),
    tileAssetUpdater(Tile, 0, P).

% Membeli rumah pada sebuah tile
buyAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    balance(P, Bal),
    tileAsset(Tile, TileAsset, P),
    TileAsset < 3, TileAsset >= 0,
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA, P).

% Membeli hotel pada sebuah tile
buyAset(P, Tile, l):-
    canBuyBasicCheck(P, Tile, 1),
    balance(P, Bal),
    tileAsset(Tile, TileAsset, P),
    TileAsset =:= 3,
    propertyPrices(Tile, Prices),
    TA2 is TileAsset + 1,
    getElmt(TA2, Prices, Price),
    Bal >= Price,
    subtractBalance(P, Price),
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA).

% Menjual utuh tile
sellAset(P, Tile, t):- 
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
    TileAsset =:= 0,
    NTA is -2,
    propertyPrices(Tile, Prices),
    getElmt(Prices, 0, Price),
    addBalance(P, Price),
    tileAssetUpdater(Tile, NTA).

% Menjual rumah pada sebuah tile
sellAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset, P),
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
    tileAsset(Tile, TileAsset, P),
    TileAsset =:= 4,
    propertyPrices(Tile, Prices),
    getElmt(Prices, TileAsset, Price),
    SPrice is Price / 2,
    addBalance(P, SPrice),
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

assetValue(Tile, Value) :-
    tileAsset(Tile, Level, _),
    propertyPrices(Tile, Prices),
    sumUntil(Prices, Level, Value).

assetCounter([], CurrentVal, CurrentVal).
assetCounter([H|T], CurrentVal, Result) :-
    assetValue(H, Value),
    Newval is CurrentVal + Value,
    assetCounter(T, Newval, Result).

totalAsset(Player, Amount) :- 
    tileInventory(Player, Inventory),
    assetCounter(Inventory, 0, Amount).

sellTileByIndex(Index, Player) :- % Jual keseluruhan asset beserta bangunannya
    tileInventory(Player, Inventory),
    getElmt(Inventory, Index, Tile),
    tileAsset(Tile, _, Player),
    assetValue(Tile, Value),
    SellValue is 0.8*Value,
    deleteAt(Inventory, Index, NewInventory),
    tileInventoryUpdater(Player, NewInventory),
    tileAssetUpdater(Tile, -2), % update jadi tidak bertuan
    addBalance(Player, SellValue).
