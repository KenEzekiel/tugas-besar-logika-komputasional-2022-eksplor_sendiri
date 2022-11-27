:- include('./map_fact.pl').
:- include('./list.pl').
:- include('./map_rules.pl').
:- include('./player.pl').
:- include('./chancecard.pl').
:- include('./dice.pl').
:- include('./jail.pl').
:- include('./turns.pl').
:- include('./rent.pl').
:- include('./aset.pl').
:- include('./taxes.pl').
:- include('./command.pl').

start :-
    repeat,
    read(fafa).
    
    declarePermanentBankruptcy(Player).