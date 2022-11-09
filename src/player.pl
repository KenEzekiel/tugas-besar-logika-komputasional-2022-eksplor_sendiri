player(v).
player(w).

:- dynamic(location/2).
:- dynamic(inventory/2).

cardlist([tax, prize, getout, gotojail]).

location(v, go).
location(w, go).

inventory(v, []).
inventory(w, []).

movePlayerTo(Player, Location) :- retract(location(Player, _)), asserta(location(Player, Location)).

movePlayerStep(Player, Step) :- 
  retract(location(Player, Prev)), 
  board(Board), boardLength(BoardLen), 
  indexOf(Board, Prev, IPrev), INext is (IPrev + Step) mod BoardLen,
  getElmt(Board, INext, Next),
  asserta(location(Player, Next)).

insertToInventory(Player, Card) :-
  isCardValid(Card, Ans),
  Ans =:= 0,
  retract(inventory(Player, Inventory)),
  insertElmtLast(Inventory, Card, A),
  asserta(inventory(Player, A)).

isCardValid(Card, Answer) :-
  cardlist(List),
  isElmt(List, Card, Answer).