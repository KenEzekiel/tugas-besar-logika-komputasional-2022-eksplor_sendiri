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
    format('Kepemilikan\t\t: Player ~w', [Owner]), nl, 
    propertyRent(Location, Property, RentCost),
    format('Biaya Sewa Saat Ini\t: ~d', [RentCost]), nl, 
    acquisitionPrice(Location, Property, AcCost),
    (AcCost \= -1 -> format('Biaya Akuisisi\t\t: ~d', [AcCost]) ; doNothing), nl,
    write('Tingkatan Properti\t: '),
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
  format('Harga Tanah\t\t: ~d', [PTanah]), nl,
  format('Harga Bangunan 1\t: ~d', [PBangunan1]), nl,
  format('Harga Bangunan 2\t: ~d', [PBangunan2]), nl,
  format('Harga Bangunan 3\t: ~d', [PBangunan3]), nl,
  format('Harga Landmark\t\t: ~d', [PLandmark]), nl, nl,
  propertyRent(Location, [RTanah, RBangunan1, RBangunan2, RBangunan3, RLandmark]),  
  format('Biaya Sewa Tanah\t: ~d', [RTanah]), nl,
  format('Biaya Sewa Bangunan 1\t: ~d', [RBangunan1]), nl,
  format('Biaya Sewa Bangunan 2\t: ~d', [RBangunan2]), nl,
  format('Biaya Sewa Bangunan 3\t: ~d', [RBangunan3]), nl,
  format('Biaya Sewa Landmark\t: ~d', [RLandmark]).


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
