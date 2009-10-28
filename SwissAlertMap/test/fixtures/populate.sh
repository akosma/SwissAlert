#!/usr/bin/env sh

# Location          Lat     Long
# Aarau             47.383  8.066
# Aare              47.550  8.230
# Basel             47.583  7.583
# Bellinzona        46.183  9.016
# Bern              46.950  7.466
# Bernina, Piz      46.333  9.900
# Biel              47.133  7.233
# Brig              46.300  7.983
# Chur              46.866  9.533
# Davos             46.800  9.816
# Engadin           46.750  10.166
# Fribourg          46.816  7.150
# Geneve            46.200  6.150
# Interlaken        46.683  7.833
# Jungfrau          46.533  7.966
# La Chaux-de-Fonds 47.116  6.833
# Lausanne          46.533  6.633
# Locarno           46.166  8.783
# Lucerne           47.050  8.300
# Lugano            46.016  8.950
# Luzern            47.000  8.300
# Martigny          46.100  7.050
# Maatterhorn       45.966  7.650
# Montreux          46.433  6.916
# Neuchatel         47.000  6.916
# Neuchatel Lac de  46.883  6.833
# St. Gotthard P.   46.550  8.550
# Schaffhausen      47.700  8.650
# Schwyz            47.350  8.650
# Simplonpass       46.250  8.050
# Solothurn         47.216  7.533
# Thun              46.750  7.633
# Zug               47.166  8.516
# Zurich            47.366  8.533

curl -F "latitude=47.366" -F "longitude=8.533" http://localhost:3000/
curl -F "latitude=47.000" -F "longitude=8.300" http://localhost:3000/
curl -F "latitude=46.533" -F "longitude=6.633" http://localhost:3000/
curl -F "latitude=46.550" -F "longitude=8.550" http://localhost:3000/
