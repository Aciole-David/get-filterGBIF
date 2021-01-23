#!/bin/bash

#David Aciole Barbosa
#Mestre e doutorando em Biotecnologia
#Universidade de Mogi das Cruzes
#https://github.com/Aciole-David

#Obter dados do banco GBIF a partir de grandes listas do site e uma lista de espécies alvo. 

#ignorar acentos no arquivo:
#iconv -f utf8 -t ascii//TRANSLIT "ARQUIVO"

#Encontrar caracteres diacriticos (acentos, til, etc) no ARQUIVO-ORIGINAL,
#Comparando-o com noaccents-file.txt, que é a versão do arquivo sem diacriticos: 
#cat ARQUIVO-ORIGNAL | iconv -f utf8 -t ascii//TRANSLIT > noaccents-file.txt && diff species-list.txt noaccents-file.txt | grep '<'


export LC_ALL=C #force standard language format

echo "Obter dados do banco GBIF a partir de grandes listas do site e uma lista de espécies alvo."

echo "Criando pastas temporarias"

mkdir temp/
IFS="
" #necessário para definir a quebra de linha, senão o comando cat busca palavra por palavra, ao invés da linha toda

#obter primeira linha do arquivo original para gerar cabecalho
echo "Obter primeira linha do arquivo original para gerar cabecalho"
head -n 1 formicidae-gbif.txt>temp/header.txt

#Obter apenas sete colunas do arquivo;
#gbifID, scientificName, decimalLatitude, decimalLongitude, basisOfRecord, colectionCode e catalogNumber:
echo "Obter apenas sete colunas do arquivo; gbifID, scientificName, decimalLatitude, decimalLongitude, basisOfRecord, collectionCode e catalogNumber:"
sort -u -t$'\t' formicidae-gbif.txt| awk '{print $1, $13, $22, $23, $36, $38, $39}' FS=$'\t' OFS=$'\t'>temp/sete-colunas.txt

#Obter sete colunas do arquivo de cabecalho
echo "Obter sete colunas do arquivo de cabecalho"
sort -u -t$'\t' temp/header.txt| awk '{print $1, $13, $22, $23, $36, $38, $39}' FS=$'\t' OFS=$'\t'>temp/header-sete-colunas.txt


echo "Removendo linhas vazias na coluna 3, decimalLatitude..."
awk  '$3!=""' FS=$'\t' OFS=$'\t' temp/sete-colunas.txt > temp/tem-decimal-latitude.txt
echo -e "Linhas vazias na coluna 3, decimalLatitude, removidas.\n"

echo "Removendo linhas vazias na coluna 7, catalogNumber..."
awk  '$7!=""' FS=$'\t' OFS=$'\t' temp/tem-decimal-latitude.txt > temp/tem-catalog-number.txt
echo -e "Linhas vazias na coluna 7, catalogNumber, removidas.\n"

echo "Removendo linhas contendo 'NO-DISPONIBLE' na coluna 7, catalogNumber..."
awk  '$7!="NO DISPONIBLE"' FS=$'\t' OFS=$'\t' temp/tem-catalog-number.txt > temp/no-NO-DISPONIBLE.txt
echo -e "Linhas linhas contendo 'NO-DISPONIBLE' na coluna 7, catalogNumber removidas.\n"

#FIltrar linhas que contenham as species alvo
echo -e "Filtrando linhas contendo espécies alvo\n"
for i in `cat species-list.txt`; do #duplicou os nomes cientificos para ter uma versao com e uma sem acentos diacriticos
echo "Filtrando linhas contendo a espécie $i..."


awk -v a="$i" '$2==a' FS=$'\t' temp/no-NO-DISPONIBLE.txt>>temp/especies-alvo.txt;

done
echo -e "\nFiltragem de espécies concluida.\n"

echo "Obtendo valores maximo e mínimo da coluna 'decimalLatitude', para cada espécie, na lista de especies alvo..."
for i in `cat species-list.txt`; do
awk -v a="$i" '$2==a' FS=$'\t' temp/especies-alvo.txt | LC_ALL=C sort -t$'\t' -k3 -rg | head -1 >>temp/ordenados.txt
awk -v a="$i" '$2==a' FS=$'\t' temp/especies-alvo.txt | LC_ALL=C sort -t$'\t' -k3 -g | head -1 >>temp/ordenados.txt
done


echo -e "Valores maximo e mínimo da coluna 'decimalLatitude' para cada espécie obtido.\n"

cat temp/header-sete-colunas.txt temp/ordenados.txt>temp/amplitudes.txt
echo "Adicionando cabecalho ao arquivo..."

echo -e "Montando novo cabecalho para a saida de especies na mesma linha..."
echo -e "gbifID\tscientificName\tdecimalLatitude\tdecimalLongitude\tbasisOfRecord\tcollectionCode\tcatalogNumber\tgbifID\tscientificName\tdecimalLatitude\tdecimalLongitude\tbasisOfRecord\tcollectionCode\tcatalogNumber">temp/bigheader.txt

echo -e "Montando ponto maximo e mínimo na mesma linha para cada espécie.\n"
for i in `cat species-list.txt`; do
awk -v a="$i" 'BEGIN { ORS="@sep@" } $2==a' FS=$'\t' OFS=$'\t' temp/amplitudes.txt | sed 's/$/@break@/'>>temp/mesmalinha.txt
#awk esta separando por "@sep@". Simplesmente para evitar usar caracteres que ja estejam no arquivo original  
#sed esta adicionando "@break@" ao final das linhas
done

#agora remove @break@ e @sep@:
sed -r 's/@break@/\n/g' temp/mesmalinha.txt>temp/amplitudes2.txt
sed -r 's/@sep@/\t/g' temp/amplitudes2.txt>temp/amplitudes3.txt

echo -e "Quase acabando...\n"

echo -e "Unindo cabecalho ao arquivo final...\n"
cat temp/bigheader.txt temp/amplitudes3.txt>final-amplitudes.txt

echo -e "Tudo pronto! Os resultados estão no arquivo 'final-amplitudes.txt'\n"

rm -R ./temp

