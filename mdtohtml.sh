#!/bin/bash -e
if [[ -z "$1" ]] ; then
    echo 'Add project path there'
    echo 'It should have md files which you convert to HTMLs'
    echo 'For example "BasicsOfWeb"'
    exit 0
fi

# unwanted folders
pgw="PgwSlideshow-master"
nodemod="node_modules"

cd ./../$1
echo "##########"
echo "MD TO HTML"
echo "##########"
echo ""
echo "Working currently in folder:"
pwd
FILES=$(find -name '*.md')
for f in $FILES
do
    fext=$(basename "${f%.*}")
    dirname=$(dirname "${f}")
    # If the dir contains a folder we dont want to convert, skip it by adding here
    case "$dirname" in 
        *"$pgw"*) 
        echo "skipping unwanted file on folder $pgw"
        continue
        ;;
        *"$nodemod"*)
        echo "skipping unwanted file on folder $nodemod"
        continue
        ;;
    esac
    echo "processing $f"
    shrtdir=${dirname##?}
    filename="${fext%.*}"
    mkdir -p ./html/$shrtdir
    cp ./../mdtohtml/style.css ./html/$shrtdir
    pandoc -s -c style.css $f -o ./html/$shrtdir/$filename.html --metadata pagetitle="$filename - $1"
done
echo "all done"
