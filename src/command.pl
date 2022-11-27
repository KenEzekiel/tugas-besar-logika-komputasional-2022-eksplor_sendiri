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

dynamic(playerState/2).

playerState(v, diceThrown).
playerState(w, diceThrown).
playerState(w, jailed).
playerState(v, jailed).

stateChanger(Player, NewState):-
    retractall(turn(Player, _)),
    asserta(turn(Player, NewState)).



cash:-
    turn(Player, 1),
    balance(Player, Balance),
    format('Uang: ~d', [Balance]), !.

buy:-
    turn(Player, 1),
    playerState(Player, diceThrown),
    location(Player, Tile),
    tileAsset(Tile, Status, Owner) -> (
        checkPropertyDetail(Tile)
    ) ; (
        write('Deadmanlands')
    ).





/*
buy:-
    turn(Player, 1),
    buy.
*/
