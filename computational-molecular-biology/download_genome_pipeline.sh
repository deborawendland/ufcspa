directory=atividade-01
mkdir $directory
cd $directory

url='http://ftp.ensembl.org/pub/release-93/fasta/danio_rerio/dna/Danio_rerio.GRCz11.dna.chromosome.replace.fa.gz'
for count in $(seq 1 25);
do
  wget ${url/replace/$count}
done
gunzip $(ls)


