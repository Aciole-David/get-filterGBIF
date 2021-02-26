# get-filterGBIF
Get specific data from GBIF database (https://www.gbif.org/) based on a large raw list from the site (dbf) and a target species list (spl). 

# If you use this code, remember to cite it as well as GBIF!

## author:
Msc David Aciole Barbosa, PhD student

Biotechnology Postgraduate Program

University of Mogi das Cruzes

https://github.com/Aciole-David

### motivation:
This script was kindly created to MSc Nathalia Sampaio da Silva

(LAMAT - Mirmecology Laboratory of Alto-Tietê, University of Mogi das Cruzes),

to get data from an ant spl, but it should  work with any spl.

Just make sure to get the proper dbf

### what it does:
dbf: a large database downloaded from GBIF (e.g., all Formicidae entries)
spl: a list of species names (e.g., some ant species from a specific location)

1 - Extract specific columns (e.g., 7 columns; gbifID, scientificName, decimalLatitude, decimalLongitude, basisOfRecord, colectionCode and catalogNumber) 

2 - Remove empty lines in column 3 and column 7

3 - Get all the lines from dbf containing the entries in spl

4 - Filters only the largest and smallest values from column 'decimalLatitude'

5 - Arrange, for each species on spl, the 7 columns for the largest decimalLatitude followed by the 7 columns for the smallet decimalLatitude.
Something like:
gbifID	scientificName	decimalLatitude	decimalLongitude	basisOfRecord	collectionCode	catalogNumber	gbifID	scientificName	decimalLatitude	decimalLongitude	basisOfRecord	collectionCode	catalogNumber
xxxxx	species1	[MAX]declat	xxxxx	xxxxx	xxxxx	xxxxx	xxxxx	species1	[MIN]declat	xxxxx	xxxxx	xxxxx	xxxxx
xxxxx	species2	[MAX]declat	xxxxx	xxxxx	xxxxx	xxxxx	xxxxx	species2	[MIN]declat	xxxxx	xxxxx	xxxxx	xxxxx
xxxxx	species3	[MAX]declat	xxxxx	xxxxx	xxxxx	xxxxx	xxxxx	species3	[MIN]declat	xxxxx	xxxxx	xxxxx	xxxxx
xxxxx	species4	[MAX]declat	xxxxx	xxxxx	xxxxx	xxxxx	xxxxx	species4	[MIN]declat	xxxxx	xxxxx	xxxxx	xxxxx
![image](https://user-images.githubusercontent.com/29051553/109365292-99aeba00-786f-11eb-9c91-2d25b3504fc4.png)


