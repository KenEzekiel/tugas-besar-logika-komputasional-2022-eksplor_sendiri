player(v).
player(w).

:- dynamic(location/2).
:- dynamic(inventory/2).
:- dynamic(balance/2).

cardlist([tax, prize, getout, gotojail]).

location(v, go).
location(w, go).

balance(v, 20000).
balance(w, 20000).

addBalance(Player, Amount) :-
  player(Player),
  balance(Player, X),
  NewX is X + Amount,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

subtractBalance(Player, Amount) :-
  player(Player),
  balance(Player, X),
  NewX is X + Amount,
  retract(balance(Player, _)),
  asserta(balance(Player,NewX)).

totalAsset(Player, Amount) :- Amount is 5000. % fungsi placeholder

netWorth(Player, Net) :-
  player(Player),
  balance(Player, Balance),
  totalAsset(Player, Asset),
  Net is Balance + Asset.

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