:- dynamic(tileAsset/2).

inventory(v, []).
inventory(w, []).

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

inventoryUpdater(P, NewInventory):-
    retractall(inventory(Tile, _)),
    asserta(inventory(Tile, NewInventory)).

inventoryAppender(P, NewTile):-
    inventory(P, Inventory),
    insertElmtLast(Inventory, NewTile, NewInventory),
    inventoryUpdater(P, NewInventory).

inventoryDeleter(P, NI):-
    inventory(P, Inventory),
    deleteElmt(Inventory, NewTile, NewInventory),
    inventoryUpdater(P, NewInventory).

colorGroupOfTile(Tile, GroupName) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList), !.

tileListOfTile(Tile, TileList) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList), !.

completeSet(P, Tile, Res):-
    colorGroupOfTile(Tile, GroupName),
    colorGroup(GroupName, TileList),
    inventory(P, Inventory),
    (\+ (isElmt(Tile_C, TileList, 1), isElmt(Tile_C, Inventory, 0)) -> Res is 1; Res is 0).

canRedeemBasicCheck(P, Tile, 0).

canRedeemBasicCheck(P, Tile, 1) :-
    turn(P, 1),
    inventory(P, Inventory),
    isElmt(Tile,Inventory, 1), !.

canBuyBasicCheck(P, Tile, Res):-
    (turn(P, 1),
    inventory(P, Inventory),
    isElmt(Tile,Inventory, 1), completeSet(P, Tile, 1)) -> Res is 1 ; Res is 0, !.

equalityCheck(Tile, Equality) :-
    tileAsset(Tile, TileAsset),
    tileListOfTile(Tile, TileList),
    \+ (isElmt(X, TileList, 1), tileAsset(X, XAsset), X < TileAsset).

buyTile(P, Tile):-
    inventory(P, Inventory),
    \+ (isElmt(Tile, Inventory, 1)),
    inventoryAppender(P, Tile).
    tileAssetUpdater(Tile, 0).

buyAset(P, Tile, m):-
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= -1,
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA).

buyAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset < 5, TileAsset >= 0,
    NTA is TileAsset + 1,
    tileAssetUpdater(Tile, NTA).

buyAset(P, Tile, h):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 4,
    NTA is TileAsset + 1.
    tileAssetUpdater(Tile, NTA).

sellAset(P, Tile, m):- 
    canRedeemBasicCheck(P, Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 0,
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

sellAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset < 5, TileAsset > 0,
    NTA is TileAsset - 1,
    tileAssetUpdater(Tile, NTA).

sellAset(P, Tile, h):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 4,
    NTA is TileAsset - 1.
    tileAssetUpdater(Tile, NTA).

    