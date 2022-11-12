isTileOwnedBy(Tile, Player) :- 
    curPropertyState(Tile, Owner, _),
    Owner =:= Player.

rentAmount(Tile, Owner, Rent) :- % todo: implementasikan multiplier untuk event tertentu (BONUS)
    curPropertyState(Tile, Owner, PropertyLevel),
    propertyRent(Tile, PropertyLevel, Rent).

isAbleToPayRent(Tile, Player) :- % pastikan tile sudah dimiliki oleh player lawan. Periksa dengan relasi isTileOwnedBy
    rentAmount(Tile, _, Rent),
    balance(Player, Balance),
    Balance >= Rent.

payRent(Tile, Payer) :- % pastikan player bisa bayar rent. Periksa dengan relasi isAbleToPayRent
    rentAmount(Tile, Owner, Rent),
    addBalance(Owner, Rent),
    subtractBalance(Payer, Rent).
