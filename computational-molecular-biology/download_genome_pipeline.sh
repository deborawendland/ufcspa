directory=atividade-01
fasta_name=all_chromosomes.fa
mkdir $directory
cd $directory

url='http://ftp.ensembl.org/pub/release-93/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.chromosome.replace.fa.gz'
echo "downloading chromossomes 1..25..."
for count in $(seq 1 25);
do
  wget ${url/replace/$count} -q --show-progress
done

echo "downloading mt chromossome..."
wget ${url/replace/MT}

echo "unzipping .gz files..."
gunzip $(ls)

touch $fasta_name

echo "adding files content to " $fasta_name "..."
for filename in $(ls);
do
  echo $filename
  cat $filename >> $fasta_name
done

echo "counting base pairs in chromosomes..."
for filename in $(ls);
do
  substring=$(sed -e 's/REF\(.*\)>/\1/' <<< $(cat $filename)) #Entre REF e >, para cada repeticao
  echo "Genoma lenght: " ${#substring}
done

echo "counting base pairs in chromosomes of " $fasta_name "..."
substring=$(sed -e 's/REF\(.*\)>/\1/' <<< $(cat fasta_name)) #Entre REF e >, para cada repeticao
echo "Genoma lenght: " ${#substring}

cds_all=http://ftp.ensembl.org/pub/release-93/fasta/danio_rerio/cds/Danio_rerio.GRCz11.cds.all.fa.gz
echo "downloading and unzipping" $cds_all "..."
wget $cds_all -q --show-progress
gunzip Danio_rerio.GRCz11.cds.all.fa.gz

echo "Gene count: " $(cat Danio_rerio.GRCz11.cds.all.fa | tr -cd '>' | wc -c)




