getElmt([], _, _) :- fail.
getElmt([X|_], I, R) :- I is 1, !, R is X.
getElmt([_|Y], I, R) :- I1 is I - 1, getElmt(Y, I1, R).

sumUntil([], _, 0) :- !.
sumUntil([X|_], 0, X) :- !.
sumUntil([X|Y], IndexUntil, Res) :- IndexNext is IndexUntil - 1, sumUntil(Y, IndexNext, Res2), Res is Res2 + X.