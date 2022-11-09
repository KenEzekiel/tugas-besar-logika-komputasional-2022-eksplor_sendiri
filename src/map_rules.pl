:- dynamic(curPropertyState/3).

/* ini buat testing doang, nanti harusnya pake dynamic predicate */
curPropertyState(a1, v, 4).
curPropertyState(e1, v, 4).
curPropertyState(e2, v, 4).
curPropertyState(e3, v, 4).
curPropertyState(f1, v, 4).
curPropertyState(f2, v, 4).
curPropertyState(d3, v, 0).
curPropertyState(g1, v, 1).
curPropertyState(h2, w, 4).

/* Get property and rent price based on location and property */
propertyPrice(Location, Property, Price) :- propertyPrices(Location, Prices), getElmt(Prices, Property, Price). 
propertyRent(Location, Property, Price) :- propertyRents(Location, Prices), getElmt(Prices, Property, Price). 


/* Get acquisition price based on location and property */
acquisitionPrice(Location, Property, Price) :- 
  Property = 4 -> Price is -1 ; 
  propertyPrices(Location, Prices), sumUntil(Prices, Property, Sum), Price is Sum * 2.

doNothing.

showPropertyStatus(Location) :- 
  curPropertyState(Location, Owner, Property) ->  
  (
    write('Kepemilikan\t\t: Player '), write(Owner), 
    propertyRent(Location, Property, RentCost),
    write('\nBiaya Sewa Saat Ini\t: '), write(RentCost), 
    acquisitionPrice(Location, Property, AcCost),
    (AcCost \= -1 -> write('\nBiaya Akuisisi\t\t: '), write(AcCost) ; doNothing), 
    write('\nTingkatan Properti\t: '),
    Property = 0 -> write('Tanah') ; 
    (Property = 4 -> write('Landmark') ; 
    write('Bangunan '), write(Property))
  ) ;
    write('Kepemilikan\t\t: Belum ada pemilik').

checkLocationDetail(Location) :- 
  showLocNameNDesc(Location),
  showPropertyStatus(Location). /* Ini nanti diganti jadi dynamic */

checkPropertyDetail(Location) :- 
  showLocNameNDesc(Location),
  propertyPrice(Location, [PTanah, PBangunan1, PBangunan2, PBangunan3, PLandmark]),
write('Harga Tanah\t\t: '), write(PTanah),  write('\nHarga Bangunan 1\t: '), write(PBangunan1),
  write('\nHarga Bangunan 2\t: '), write(PBangunan2),
  write('\nHarga Bangunan 3\t: '), write(PBangunan3),
  write('\nHarga Landmark\t\t: '), write(PLandmark),
propertyRent(Location, [RTanah, RBangunan1, RBangunan2, RBangunan3, RLandmark]),  write('\n\nBiaya Sewa Tanah\t: '), write(RTanah),
  write('\nBiaya Sewa Bangunan 1\t: '), write(RBangunan1),
  write('\nBiaya Sewa Bangunan 2\t: '), write(RBangunan2),
  write('\nBiaya Sewa Bangunan 3\t: '), write(RBangunan3),
  write('\nBiaya Sewa Landmark\t: '), write(RLandmark).


writeLocationStatus(Location) :- 
  write('  '), 
  (curPropertyState(Location, Player, Property) -> 
    write(Player), write(Property) ; 
    write('  ')),
  write(' ').


map :- 
  write('          '), writeLocationStatus(e1), writeLocationStatus(e2), writeLocationStatus(e3),
  write('     '), writeLocationStatus(f1), writeLocationStatus(f2), writeLocationStatus(f3), nl,
  write('     ----------------------------------------------'), nl,
  write('     | FP | E1 | E2 | E3 | CC | F1 | F2 | F3 | WT |'), nl,
  write('     |----|----------------------------------|----|'), nl,
  writeLocationStatus(d3), write('| D3 |                                  | G1 |'), writeLocationStatus(g1), nl,
  write('     |----|                                  |----|'), nl,
  writeLocationStatus(d2), write('| D2 |                                  | G2 |'), writeLocationStatus(g2), nl,
  write('     |----|                                  |----|'), nl,
  writeLocationStatus(d1), write('| D1 |                                  | G3 |'), writeLocationStatus(g3), nl,
  write('     |----|          E K S P L O R           |----|'), nl,
  write('     | TX |                                  | TX |'), nl,
  write('     |----|          S E N D I R I           |----|'), nl,
  writeLocationStatus(c3), write('| C3 |                                  | CC |'), nl,
  write('     |----|                                  |----|'), nl,
  writeLocationStatus(c1), write('| C1 |                                  | h2 |'), writeLocationStatus(h2), nl,
  write('     |----|                                  |----|'), nl,
  writeLocationStatus(c2), write('| C2 |                                  | h1 |'), writeLocationStatus(h1), nl,
  write('     |----|----------------------------------|----|'), nl,
  write('     | JL | B3 | B2 | B1 | CC | A3 | A2 | A1 | GO |'), nl,
  write('     ----------------------------------------------'), nl,
  write('          '), writeLocationStatus(b3), writeLocationStatus(b2), writeLocationStatus(b1),
  write('     '), writeLocationStatus(a3), writeLocationStatus(a2), writeLocationStatus(a1), nl, nl,
  write('     Posisi pemain:'), nl,
  write('     v = '), location(v, LocV), write(LocV), nl,
  write('     w = '), location(w, LocW), write(LocW), nl.
