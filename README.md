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

First, extract specific columns (e.g., gbifID, scientificName, decimalLatitude, decimalLongitude, basisOfRecord, colectionCode and catalogNumber) 

Then, get all the lines from dbf containing the entries in spl
