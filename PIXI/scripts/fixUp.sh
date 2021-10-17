docxtotei $1.docx
perl ../Scripts/fixUp.prl $1.xml | saxon - ../Scripts/fixUp.xsl -o:$1.tmp 
saxon $1.tmp ../Scripts/divUp.xsl -o:$1.tei
# for PAF there is no docx version: use pafConv.sh instead

