#!/bin/bash
if [[ -z "$1" ]] ; then
    echo 'Add project path there'
    echo 'It should have md files which you convert to HTMLs'
    echo 'For example "BasicsOfWeb"'
    exit 0
fi

cd ./../$1
echo "##########"
echo "MD TO HTML"
echo "##########"
echo "Working currently in folder"
pwd
FILES=$(find -name '*.md')
for f in $FILES
do
    echo "processing $f"
    fext=$(basename "${f%.*}")
    dirname=$(dirname "${f}")
    shrtdir=${dirname##?}
    echo $shrtdir
    filename="${fext%.*}"
    mkdir -p ./html/$shrtdir
    cp ./../mdtohtml/style.css ./html/$shrtdir
    pandoc -s -c style.css $f -o ./html/$shrtdir/$filename.html --metadata pagetitle="$filename - $1"
done
echo "all done"