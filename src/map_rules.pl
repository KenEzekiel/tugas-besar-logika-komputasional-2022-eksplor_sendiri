:- include('./map_fact.pl').
:- include('./list.pl').

/* ini buat testing doang, nanti harusnya pake dynamic predicate */
curPropertyState(a1, v, 4).

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