:- dynamic(tileAsset/2).

tileAsset(a1,0).
tileAsset(a2,0).
tileAsset(a3,0).
tileAsset(b1,0).
tileAsset(b2,0).
tileAsset(b3,0).
tileAsset(c1,0).
tileAsset(c2,0).
tileAsset(c3,0).
tileAsset(d1,0).
tileAsset(d2,0).
tileAsset(d3,0).
tileAsset(e1,0).
tileAsset(e2,0).
tileAsset(e3,0).
tileAsset(f1,0).
tileAsset(f2,0).
tileAsset(f3,0).
tileAsset(g1,0).
tileAsset(g2,0).
tileAsset(g3,0).
tileAsset(h1,0).
tileAsset(h2,0).


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


colorGroupOfTile(Tile, GroupName) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList), !.

tileListOfTile(Tile, TileList) :-
    colorGroup(GroupName, TileList),
    isElmt(Tile, TileList), !.

completeSet(P, Tile):-
    colorGroupOfTile(Tile, GroupName),
    colorGroup(GroupName, TileList),
    inventory(P, Inventory),
    \+ (isElmt(Tile_C, TileList), \+ isElmt(Tile_C, Inventory))

canBuyBasicCheck(P, Tile, Res):-
    (turn(P, 1),
    inventory(P, Inventory),
    isElmt(Tile,Inventory), completeSet(P, Tile)) -> Res is 1 ; Res is 0.

equalityCheck(Tile, Equality) :-
    tileAsset(Tile, TileAsset),
    tileListOfTile(Tile, TileList),
    \+ (isElmt(X, TileList), tileAsset(X, XAsset), X < TileAsset).

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

sellAset(P, Tile, r):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset < 5, TileAsset >= 0,
    TileAsset > 0 -> (NTA is TileAsset - 1; NTA is TileAsset),
    tileAssetUpdater(Tile, NTA).

sellAset(P, Tile, h):-
    canBuyBasicCheck(P, Tile, 1),
    equalityCheck(Tile, 1),
    tileAsset(Tile, TileAsset),
    TileAsset =:= 4,
    NTA is TileAsset - 1.
    tileAssetUpdater(Tile, NTA).
    