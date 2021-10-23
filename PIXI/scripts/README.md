# PIXI scripts

## Versions of PIXI corpora

 The PIXI corpora derive from audio recordings of service encounters recorded in Italian and English bookshops in 1986. These tapes were then transcribed using Word Perfect and a home-brewed set of typographic conventions to represent the linguistic properties of interest to the project. These transcriptions have come down to us in four versions:
 - as a printed volume published by CLUEB in 1990
 - archived as text no 1372 at the Oxford Text Archive in 1991 
 - as an experimental XML version for analysis with Xaira in 2010
 - as redistributed to PIXI members in 2011 

The goal of the present edition was to combine the most recently corrected and complete version of the transcriptions with digitized version of the audio recordings as a single TEI-conformant resource, accessible on the web, both for reading and for further analysis.

## Procedure

The Word Perfect files used as input for the CLUEB edition survive for all but one  of the corpora. Since that version is the most recently corrected and carefully edited, we chose to work from these rather than other experimental versions, even though some of them used XML. Our starting point was a set of docx files automatically created from the original WordPerfect files.  

The shell script `fixup.sh`  does the work. For each file, it first runs the standard TEI `docxtotei` script, piping the output through a simple-minded perl script to add markup for pauses and unclear passages. This preliminary version is then processed by two more complex XSLT transformations  using the scripts `fixUp.xsl` and `divUp.xsl`. 

The only version of the Paf corpus we could find uses the same OCP-like markup as the OTA versions, though on inspection, its transcription is more detailed than the OTA version. A perl script `pafConv.prl` converts this as far as possible to the same format produced by `fixUp.xsl`, which involved some undignified fiddling with character codings amongst other things. Underlining and italicization added during the production of the CLUEB version were both missing in this version, and are therefore not present in the TEI version. 

The audio files were supplied as wav files which we compressed to mp3 files in order to reduce the size of the corpora: the audio quality of the original does not seem to have been unduly affected by this.

The documentation provided with the OTA version was checked, recoded in TEI-XML, and slightly expanded to highlight some differences between the XML and original versions. 

LB, 23 Oct 2021
