directory=atividade-01-parte-02
mkdir $directory
cd $directory

url=http://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/035/GCF_000002035.6_GRCz11/GCF_000002035.6_GRCz11_genomic.gff.gz
filename=GCF_000002035.6_GRCz11_genomic.gff
echo "downloading " $url "..."
wget $url -q --show-progress
echo "unzipping " $filename "..."
gunzip $(ls)

echo "print content of " $filename "..."
cat $filename
echo "print content of " $filename " last 20 lines..."
cat GCF_000002035.6_GRCz11_genomic.gff | tail -20
awk '{print $3}' GCF_000002035.6_GRCz11_genomic.gff | sort | uniq -c > genomic_features.txt
awk '$3 == "exon" { print $0 }' GCF_000002035.6_GRCz11_genomic.gff > exons.txt
