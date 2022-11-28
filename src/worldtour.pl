worldTour:-
    turn(Player, 1),
    \+ playerState(Player, DiceThrown), !,
    write('Maaf kamu hanya bisa menaiki Stormterror digiliran selanjutnya'), fail.

worldTour:-
    write('Kamu akan dibawa keliling dunia di punggung Stormterror, dibantu oleh Venti ?'), nl,
    write('Tetapi kamu harus membelikan Venti sejumlah minuman seharga 5000 mora.'), nl,
    write('1. Siapa takut'), nl,
    write('2. Mora ku sedikit :<'), nl,
    repeat,
    read(Input),
    (
        (Input =:= 1) -> (
            turn(Player, 1),
            balance(Player, Balance),
            (
                (Balance >= 5000) -> (
                    worldTourAccepted, !
                ) ; (
                    write('Mora kamu tidak cukup untuk membeli minuman di dawn winery'), !
                )
            )
        ) ; (
            (
                (Input =:= 2) -> (
                    write('Yah, Venti sedih karena keputusanmu :<'), !
                ) ; (
                    write('Coba masukan kembali masukan yang valid'), nl, fail
                )
            )
        )
    ).

worldTourAccepted:-
    turn(Player, 1),
    write('Pilih tile tempat Stormterror mendarat'), nl,
    repeat,
    write('Masukkan tile: '),
    read(Input),
    (
        isElmt(board, Input, Res) -> (
            format('Pegangan erat, kamu akan dibawa ke tile ~d', [Input]),
            worldTourTravel(Input), !
        ) ; (
            write('Maaf masukan tile kurang tepat'), nl,
            write('Ingat untuk menuliskan nama tile dengan lowercase'), nl, fail
        )
    ).

worldTourTravel(Input):-
    movePlayerTo(Player, Input),
