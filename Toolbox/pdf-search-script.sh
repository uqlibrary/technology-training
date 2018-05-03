# usage:
# first argument is "search term", which can be a regex
# second argument is the folder where to look for PDF files (e.g. ~/Documents/pdf-to-process/)
# You can test your regex with the RegExr website

# TODO: remove/replace non-breaking space
# TODO: look for 50 words after search term
# TODO: add Word doc functionnality
  # see https://stackoverflow.com/questions/5671988/how-to-extract-just-plain-text-from-doc-docx-files-unix?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
    # an example with basic packages unzip and sed:
      # unzip -p ./exp-docx/somefile.docx  word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g' >> doc-conv.txt
    # docx2txt (already packaged for Debian-based distributions) could be another option
    # one option that could process both Word documents and PDF: https://github.com/pzaich/doc_ripper (a bit more effort to install, less portable)
# TODO: add HTML functionnality
  # some command-line web scrapers can work

# remove previous results; ignore non-existent files with -f flag
rm -f ./results-$1.txt

# create results text file
touch ./results-$1.txt

# store the regular expression in a variable
regex="(\w+[^\w]+){1,50}(?=$1[^\w])"
# inform what regex is being used
echo "regex in use is: $regex"

for filename in $2*.pdf
do
  echo $filename
  # -i flag is for case insensitive
  # -w flag is for whole words only
  # -c flag is to count matches
  counter=`pdftotext "$filename" - | grep -iwc "$1"`
  echo "term found $counter times"
  # the second argument for pdftotext is set to "-" so it goes to stdout
  # -P flag is for Perl regex
  # -o flag is to output only the matched terms
  # -z flag searches across lines
  # -a flag so grep doesn't interpret it as binary file
  # saved to a text file with the search term appended
  pdftotext "$filename" - | tr -s [:space:] ' ' | grep -Pzaio "$regex" >> "./results-$1.txt"
done