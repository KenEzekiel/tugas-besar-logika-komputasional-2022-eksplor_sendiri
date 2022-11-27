:- dynamic(guessSuccess/1).
:- dynamic(isMinigame/1).

isMinigame(0).
guessSuccess(0).

startMinigame :- 
  retract(isMinigame(_)),
  asserta(isMinigame(1)),
  write('Kamu sekarang memasuki minigame! Lakukan command guessCoin(head) atau guessCoin(tail) untuk menebak!'), nl.


getCoin(head, X) :-
  X is 0.

getCoin(tail, X) :-
  X is 1.

getMinigamePrize(X, Prize) :-
  getElmt([0, 1000, 2000, 4000], X, Prize).

endMinigame :-
  isMinigame(1),
  retract(guessSuccess(X)),
  asserta(guessSuccess(0)),
  getMinigamePrize(X, Prize),
  write('Minigame berakhir!'), nl,
  retract(isMinigame(_)),
  asserta(isMinigame(0)),
  (Prize =:= 0 -> write('Selamat! Kamu tidak mendapatkan uang sepeserpun!'), nl
  ; format('Selamat! Kamu mendapatkan uang sebanyak ~d mora!', [Prize]),
    turn(Player, 1), !,
    addBalance(Player, Prize)).


guessCoin(Coin) :-
  isMinigame(1),
  (getCoin(Coin, Guess) ->
    randomize,
    get_seed(R),
    C is R mod 2,
    (C =:= Guess -> 
      retract(guessSuccess(X)),
      Y is X + 1,
      format('Kamu berhasil berhasil menebak dengan benar sebanyak ~d kali!', [Y]), nl,
      asserta(guessSuccess(Y)),
      (Y =:= 3 -> endMinigame ; write('Silahkan menebak lagi!'))
      ; write('Kamu gagal menebak! '), endMinigame
    ) ;
    write('Kamu salah memasukkan command! Silahkan coba lagi!'), nl
  ).
  


