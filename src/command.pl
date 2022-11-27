% :- include('./map_fact.pl').
% :- include('./list.pl').
% :- include('./map_rules.pl').
% :- include('./player.pl').
% :- include('./chancecard.pl').
% :- include('./dice.pl').
% :- include('./jail.pl').
% :- include('./turns.pl').
% :- include('./rent.pl').
% :- include('./aset.pl').
% :- include('./taxes.pl').
% :- include('./command.pl').

:- dynamic(playerState/2).


% playerState(v, diceThrown).
% playerState(w, diceThrown).
% playerState(w, jailed).
% playerState(v, jailed).

stateChanger(Player, NewState):-
    retractall(turn(Player, _)),
    asserta(turn(Player, NewState)).

cash:-
    turn(Player, 1),
    balance(Player, Balance),
    format('Uang: ~d', [Balance]), !.

getParam(Param, X):-
    Param == tanah, 
    X is 0, !.

getParam(Param, X):-
    Param == bangunan1, 
    X is 1, !.

getParam(Param, X):-
    Param == bangunan2, 
    X is 2, !.

getParam(Param, X):-
    Param == bangunan3, 
    X is 3, !.

getParam(Param, X):-
    Param == landmark, 
    X is 4, !.

getParam(_, _):-
    fail.

buy(Param):-
    turn(Player, 1),
    playerState(Player, diceThrown),
    location(Player, Tile),
    getParam(Param, X),
    tileAsset(Tile, State, Owner),
    balance(Player, Balance),
    Owner \== Player -> (
        Owner \== none -> (
            write('Gunakan command acquisition')
        ) ; (
            X =:= 0 -> (
                buyTile(Player, Tile) -> (
                    format('Anda berhasil membeli tanah ~d', [Tile])
                ) ; (
                    write('Uang anda tidak cukup')
                )
            ) ; (
                X =:= 4 -> (
                    write('Anda harus mempunyai 3 bangunan terlebih dahulu')
                ) ; (
                    propertyPrices(Tile, Prices), 
                    sumUntil(Prices, X, Sum),
                    Sum > Balance -> (
                        write('Uang anda tidak mencukupi')
                    ) ; (
                        buyTile(Player, Tile),
                        repeat,
                        buyAset(Player, Tile, r),
                        tileAsset(Tile, X, Player)
                    ) 
                )
            )
        )
    ) ; (
        X =< State -> (
            write('Anda sudah memiliki tile ataupun bangunan dengan jumlah tersebut')
        ) ; (
            X =:= 4 -> (
                State =:= 3 -> (
                    buyTile(Player, Tile, l)
                ) ; (
                    write('Anda harus mempunyai 3 bangunan terlebih dahulu')
                )
            ) ; (
                propertyPrices(Tile, Prices), 
                sumUntil(Prices, X, Sum),
                sumUntil(Prices, State, SumOwned),
                ((Sum - SumOwned) > Balance) -> (
                    write('Mora anda tidak mencukupi')
                ) ; (
                    repeat,
                    buyAset(Player, Tile, r),
                    tileAsset(Tile, X, Player)
                ) 
            )
        )
    ).