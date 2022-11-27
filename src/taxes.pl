% Berapa pajak yang player harus bayar
taxAmount(Player, Amount) :-
    netWorth(Player, Net),
    SubAmount is (Net * 0.1),
    Amount is round(SubAmount).

% Apakah player bisa bayar pajak langsung
isAbleToPayTax(Player) :-
    taxAmount(Player, Amount),
    balance(Player, Cash),
    Cash >= Amount.

% Command untuk player bayar pajak
payTax(Player) :-
    taxAmount(Player, Amount),
    (
    isAbleToPayTax(Player) -> (
        subtractBalance(Player, Amount)
    ) ; (
        write('Balance kamu tidak cukup, jual salah satu dari propertimu untuk membayar'), nl,
        repeat,
        write('Daftar propertimu:'), nl,
        tileInventory(Player, Inventory),
        displayAssets(Inventory, 1),
        write('Pilih nomor properti yang ingin dijual '),
        read(Nomor),
        Index is Nomor - 1, 
        sellTileByIndex(Index, Player),
        balance(Player, Balance),
        location(Player, Tile),
        format('Moramu sekarang ~d dan besar pajak ~d', [Balance, Amount]), nl,
        (
            isAbleToPayTax(Player) -> (
                payTax(Player),
                write('Hore, sewa sudah bisa dibayar!'), nl,
                !
            ) ; (
                write('Moramu masih kurang. Silakan pilih properti lain untuk dijual'), nl, fail
            )
        )
    )
    ).
