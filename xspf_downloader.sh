#/bin/bash
#requires cURL and wget
if [ -z $1 ]; then
    echo 'XSPF file URL must be specified, (number of files optional) ex: ./xspf_downloader.sh <URL_of_xspf_file> <number of files to download starting at top(optional)>'
    echo 'If no number of files is specified then all files will be downloaded'
    exit 1
fi
if [ -z $2 ]; then
    targets=$(curl -s -H "Content-Type: application/xml" $1 |sed -n -e 's/.*<location>\(.*\)<\/location>.*/\1/p');
else targets=$(curl -s -H "Content-Type: application/xml" $1 |sed -n -e 's/.*<location>\(.*\)<\/location>.*/\1/p'|head -n $2);
fi
if [ -z $targets ]; then 
    echo 'No media urls found'
    exit 1
fi
for i in `echo $targets`; do wget $i; done;
