#!/bin/sh -e
SAXONURL=https://sourceforge.net/projects/saxon/files/Saxon-HE/10/Java/SaxonHE10-5J.zip/download
SAXON=saxon-he-10.5.jar
XML=JMDict_e
OUT=jmdict.xml
XSL=jmdict2macos.xsl

if [[ ! -e "${SAXON}" ]]; then
    echo "[!] Saxon not found. Trying to download."
    SAXON_ZIP=$(mktemp)
    if curl -s -L -o "${SAXON_ZIP}" "${SAXONURL}" > /dev/null; then
        echo "[ ] Extracting."
        unzip "${SAXON_ZIP}" "${SAXON}"
        rm "${SAXON_ZIP}"
        echo "[+] Saxon is ready to use."
    else
    echo "[-] Saxon download failed."
    exit 1
    fi
fi

TMP_XML=$(mktemp)

echo "[ ] Expanding entities."
sed 's?ENTITY \([^ ]*\) "\(.*\)"?ENTITY \1 "<ent tit=\&#34;\2\&#34;>\1</ent>"?' "${XML}" > "${TMP_XML}"
echo "[+] Expanding entities...done"

echo "[ ] Transforming."
java -Duser.language=en -DentityExpansionLimit=2000000 -Xmx1024M -jar "${SAXON}" -s:"${TMP_XML}" -opt:10 -t -xsl:"${XSL}" -o:"${OUT}"
echo "[+] Transforming...done"

echo "[ ] Cleaning up."
rm "${TMP_XML}"
echo "[+] Cleaning up...done"
