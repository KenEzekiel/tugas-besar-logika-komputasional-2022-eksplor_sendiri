board([go, a1, a2, a3, cc, b1, b2, b3, jl, c1, c2, c3, tx, d1, d2, d3, fp, e1, e2, e3, cc, f1, f2, f3, wt, g1, g2, g3, tx, cc, h1, h2]).

boardLength(32).

/* ini buat testing doang, nanti harusnya pake dynamic predicate */
curPropertyState(a1, v, 5000, 10000, 0).


showPropertyStatus(Location) :- 
  curPropertyState(Location, Owner, RentCost, AcCost, Property) ->  
  (
    write('Kepemilikan\t\t: Player '), write(Owner), 
    write('\nBiaya Sewa Saat Ini\t: '), write(RentCost), 
    write('\nBiaya Akuisisi\t\t: '), write(AcCost), 
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
  propertyPrice(Location, PTanah, PBangunan1, PBangunan2, PBangunan3, PLandmark),
  write('Harga Tanah\t\t: '), write(PTanah),
  write('\nHarga Bangunan 1\t: '), write(PBangunan1),
  write('\nHarga Bangunan 2\t: '), write(PBangunan2),
  write('\nHarga Bangunan 3\t: '), write(PBangunan3),
  write('\nHarga Landmark\t\t: '), write(PLandmark),
  propertyRent(Location, RTanah, RBangunan1, RBangunan2, RBangunan3, RLandmark),
  write('\n\nBiaya Sewa Tanah\t: '), write(RTanah),
  write('\nBiaya Sewa Bangunan 1\t: '), write(RBangunan1),
  write('\nBiaya Sewa Bangunan 2\t: '), write(RBangunan2),
  write('\nBiaya Sewa Bangunan 3\t: '), write(RBangunan3),
  write('\nBiaya Sewa Landmark\t: '), write(RLandmark).


/* Template ini tinggal di-copas aja untuk semua lokasi */
showLocNameNDesc(a1) :- write('\nNama Lokasi\t\t: Jakarta\n'),
  write('Deskripsi Lokasi\t: Ibukota Indonesia\n\n').

propertyPrice(a1, Tanah, Bangunan1, Bangunan2, Bangunan3, Landmark) :- 
  Tanah = 200, Bangunan1 = 1000, Bangunan2 = 2000, Bangunan3 = 3000, Landmark = 3000.

propertyRent(a1, Tanah, Bangunan1, Bangunan2, Bangunan3, Landmark) :- 
  Tanah = 20, Bangunan1 = 120, Bangunan2 = 350, Bangunan3 = 600, Landmark = 1000.