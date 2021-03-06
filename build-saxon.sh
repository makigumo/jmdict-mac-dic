#!/bin/sh -e
SAXONURL=https://sourceforge.net/projects/saxon/files/Saxon-HE/10/Java/SaxonHE10-2J.zip/download
SAXON=saxon-he-10.2.jar
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

echo "[ ] Pruning entities."
sed 's/ENTITY \([^ ]*\) ".*"/ENTITY \1 "\1"/' "${XML}" > "${TMP_XML}"
echo "[+] Pruning entities...done"

echo "[ ] Transforming."
java -DentityExpansionLimit=2000000 -Xmx1024M -jar "${SAXON}" -s:"${TMP_XML}" -opt:10 -t -xsl:"${XSL}" -o:"${OUT}"
echo "[+] Transforming...done"

echo "[ ] Cleaning up."
rm "${TMP_XML}"
echo "[+] Cleaning up...done"
