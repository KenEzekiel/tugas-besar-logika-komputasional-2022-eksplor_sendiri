board([go, a1, a2, a3, cc1, b1, b2, b3, jl, c1, c2, c3, tx1, d1, d2, d3, fp, e1, e2, e3, cc2, f1, f2, f3, wt, g1, g2, g3, tx2, cc3, h1, h2]).

boardLength(32).

/* a1 */
showLocNameNDesc(a1) :- write('\nNama Lokasi\t\t: Mondstadt\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Mondstadt\n\n').

/* a2 */
showLocNameNDesc(a2) :- write('\nNama Lokasi\t\t: Dawn Winery\n'),
  write('Deskripsi Lokasi\t: Wilayah pembuat wine\n\n').

/* a3 */
showLocNameNDesc(a3) :- write('\nNama Lokasi\t\t: Springvale\n'),
  write('Deskripsi Lokasi\t: Desa pemburu\n\n').

/* b1 */
showLocNameNDesc(b1) :- write('\nNama Lokasi\t\t: Stormterror s Lair\n'),
  write('Deskripsi Lokasi\t: Sarang naga\n\n').

/* b2 */
showLocNameNDesc(b2) :- write('\nNama Lokasi\t\t: Wolvendom\n'),
  write('Deskripsi Lokasi\t: Makam arwah serigala\n\n').

/* b3 */
showLocNameNDesc(b3) :- write('\nNama Lokasi\t\t: Dragonspine\n'),
  write('Deskripsi Lokasi\t: Wilayah bersalju\n\n').

/* c1 */
showLocNameNDesc(c1) :- write('\nNama Lokasi\t\t: Qingce Village\n'),
  write('Deskripsi Lokasi\t: Tempat pensiun orang tua\n\n').

/* c2 */
showLocNameNDesc(c2) :- write('\nNama Lokasi\t\t: Wangshu Inn\n'),
  write('Deskripsi Lokasi\t: Tempat pemberhentian pedagang\n\n').

/* c3 */
showLocNameNDesc(c3) :- write('\nNama Lokasi\t\t: Liyue Harbor\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Liyue\n\n').

/* d1 */
showLocNameNDesc(d1) :- write('\nNama Lokasi\t\t: Jade Chamber\n'),
  write('Deskripsi Lokasi\t: Istana Ningguang\n\n').

/* d2 */
showLocNameNDesc(d2) :- write('\nNama Lokasi\t\t: The Chasm\n'),
  write('Deskripsi Lokasi\t: Wilayah penambangan\n\n').

/* d3 */
showLocNameNDesc(d3) :- write('\nNama Lokasi\t\t: Qingyun Peak\n'),
  write('Deskripsi Lokasi\t: Rumahnya para adeptus\n\n').

/* e1 */
showLocNameNDesc(e1) :- write('\nNama Lokasi\t\t: Inazuma City\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Inazuma\n\n').

/* e2 */
showLocNameNDesc(e2) :- write('\nNama Lokasi\t\t: Ritou\n'),
  write('Deskripsi Lokasi\t: Pelabuhan Inazuma\n\n').

/* e3 */
showLocNameNDesc(e3) :- write('\nNama Lokasi\t\t: Kamisato Estate\n'),
  write('Deskripsi Lokasi\t: Perumahan Kamisato\n\n').

/* f1 */
showLocNameNDesc(f1) :- write('\nNama Lokasi\t\t: Grand Narukami Shrine\n'),
  write('Deskripsi Lokasi\t: Kuil penjaga pohon sakura keramat\n\n').

/* f2 */
showLocNameNDesc(f2) :- write('\nNama Lokasi\t\t: Kujou Encampment\n'),
  write('Deskripsi Lokasi\t: Benteng Kujou\n\n').

/* f3 */
showLocNameNDesc(f3) :- write('\nNama Lokasi\t\t: Sangonomiya Shrine\n'),
  write('Deskripsi Lokasi\t: Markas tentara perlawanan\n\n').

/* g1 */
showLocNameNDesc(g1) :- write('\nNama Lokasi\t\t: Gandharva Ville\n'),
  write('Deskripsi Lokasi\t: Desa penjaga hutan\n\n').

/* g2 */
showLocNameNDesc(g2) :- write('\nNama Lokasi\t\t: Sumeru City\n'),
  write('Deskripsi Lokasi\t: Pusat wilayah Sumeru\n\n').

/* g3 */
showLocNameNDesc(g3) :- write('\nNama Lokasi\t\t: Port Osmos\n'),
  write('Deskripsi Lokasi\t: Pelabuhan pusat Sumeru\n\n').

/* h1 */
showLocNameNDesc(h1) :- write('\nNama Lokasi\t\t: Caravan Ribat\n'),
  write('Deskripsi Lokasi\t: Pembatas sumeru dengan wilayah padang pasir\n\n').

/* h2 */
showLocNameNDesc(h2) :- write('\nNama Lokasi\t\t: Aaru Village\n'),
  write('Deskripsi Lokasi\t: Wilayah pengikut Raja Scarlet dan tempat pembuangan pelajar Sumeru\n\n').

propertyPrices(a1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(a2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(a3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(b1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(b2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(b3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(c1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(c2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(c3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(d1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(d2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(d3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(e1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(e2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(e3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(f1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(f2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(f3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(g1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(g2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(g3, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(h1, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].
propertyPrices(h2, Prices) :- Prices = [200, 1000, 2000, 3000, 3000].

propertyRents(a1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(a2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(a3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(b1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(b2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(b3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(c1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(c2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(c3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(d1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(d2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(d3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(e1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(e2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(e3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(f1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(f2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(f3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(g1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(g2, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(g3, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(h1, Prices) :- Prices = [20, 120, 350, 600, 1000].
propertyRents(h2, Prices) :- Prices = [20, 120, 350, 600, 1000].