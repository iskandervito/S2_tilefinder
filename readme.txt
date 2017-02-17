Instructions to follow
-------------------------

- prepare your bounding box coordinates defined by top left latitude/longitude and bottom right latitude/longitude
- open the S2_tilefinder.m script and just fill in these parameters using your own coordinates
topLeftLat = 52;
topLeftLon = 5;
bottomRightLat = 50;
bottomRightLon = 8;
-run the matlab script.

The script will ouptut the Sentinel2 tiles intersecting your region of interest. Below an example of output using the exmaple coordinates listed above:

Found possible 31U UTM zone search
Found possible 32U UTM zone search
Found S2 tile :31UFR [minLon = 4.385169,minLat = 49.619417,maxLon = 5.821311,maxLat = 50.543380]
Found S2 tile :31UGR [minLon = 5.769058,minLat = 49.613658,maxLon = 6.000000,maxLat = 50.517741]
Found S2 tile :31UFS [minLon = 4.411339,minLat = 50.517741,maxLon = 5.876292,maxLat = 51.442352]
Found S2 tile :31UGS [minLon = 5.821311,minLat = 50.513270,maxLon = 6.000000,maxLat = 51.415884]
Found S2 tile :31UFT [minLon = 4.438877,minLat = 51.415884,maxLon = 5.934190,maxLat = 52.341175]
Found S2 tile :31UGT [minLon = 5.876292,minLat = 51.412780,maxLon = 6.000000,maxLat = 52.313844]
Found S2 tile :32UKA [minLon = 6.000000,minLat = 49.613658,maxLon = 6.230942,maxLat = 50.517741]
Found S2 tile :32ULA [minLon = 6.178689,minLat = 49.619417,maxLon = 7.614831,maxLat = 50.543380]
Found S2 tile :32UMA [minLon = 7.588661,minLat = 49.644257,maxLon = 9.000000,maxLat = 50.551932]
Found S2 tile :32UKB [minLon = 6.000000,minLat = 50.513270,maxLon = 6.178689,maxLat = 51.415884]
Found S2 tile :32ULB [minLon = 6.123708,minLat = 50.517741,maxLon = 7.588661,maxLat = 51.442352]
Found S2 tile :32UMB [minLon = 7.561123,minLat = 50.543380,maxLon = 9.000000,maxLat = 51.451182]
Found S2 tile :32UKC [minLon = 6.000000,minLat = 51.412780,maxLon = 6.123708,maxLat = 52.313844]
Found S2 tile :32ULC [minLon = 6.065810,minLat = 51.415884,maxLon = 7.561123,maxLat = 52.341175]
Found S2 tile :32UMC [minLon = 7.532122,minLat = 51.442352,maxLon = 9.000000,maxLat = 52.350293]
Elapsed time is 2.644927 seconds.

In addition to output script, a figure is displayed showing :
- the requested bounding box in blue color
- the tested S2 tilesin red
- the selected S2 tiles green

Any remarks or suggestion, please contact me iskander.benhadj@vito.be