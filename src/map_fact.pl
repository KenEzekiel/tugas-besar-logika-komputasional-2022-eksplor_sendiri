board([go, a1, a2, a3, cc, b1, b2, b3, jl, c1, c2, c3, tx, d1, d2, d3, fp, e1, e2, e3, cc, f1, f2, f3, wt, g1, g2, g3, tx, cc, h1, h2]).

boardLength(32).

showLocationStatus(Owner, RentCost, AcquisitionCost, Property) :- 
    write('Kepemilikan\t\t: Player '), write(Owner), 
    write('\nBiaya Sewa Saat Ini\t: '), write(RentCost), 
    write('\nBiaya Akuisisi\t\t: '), write(AcquisitionCost), 
    write('\nTingkatan Properti\t: '), 
    Property = 0 -> write('Tanah') ; 
    (Property = 4 -> write('Landmark') ; 
    write('Bangunan '), write(Property)).


/* Template ini tinggal di-copas aja untuk semua lokasi */
checkLocationDetail(a1) :- 
  write('\nNama Lokasi\t\t: Jakarta\n'),
  write('Deskripsi Lokasi\t: Ibukota Indonesia\n\n'),
  showLocationStatus(v, 10000, 7000, 0). /* Ini nanti diganti jadi dynamic */
