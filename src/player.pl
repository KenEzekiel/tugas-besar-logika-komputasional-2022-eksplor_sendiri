player(v).
player(w).

:- dynamic(location/2).

location(v, go).
location(w, go).

movePlayerTo(Player, Location) :- retract(location(Player, _)), asserta(location(Player, Location)).

movePlayerStep(Player, Step) :- 
  retract(location(Player, Prev)), 
  board(Board), boardLength(BoardLen), 
  indexOf(Board, Prev, IPrev), INext is (IPrev + Step) mod BoardLen,
  getElmt(Board, INext, Next),
  asserta(location(Player, Next)).