#!/bin/sh -e
SAXONURL=https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-9/SaxonHE12-9J.zip
SAXON=saxon-he-12.9.jar
XML=JMDict_e
OUT=jmdict.xml
XSL=jmdict2macos.xsl

if [ ! -e "${SAXON}" ]; then
    echo "[!] Saxon not found. Trying to download."
    SAXON_ZIP=$(mktemp)
    if curl -s -L -o "${SAXON_ZIP}" "${SAXONURL}" > /dev/null; then
        echo "[ ] Extracting."
        unzip "${SAXON_ZIP}"
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
# required minimum as of march 2026
#
# entityExpansionLimit           500.000
# entityReplacementLimit       1.300.000
# totalEntitySizeLimit        20.000.000
#
# double those values
java -Duser.language=en \
  -Djdk.xml.entityExpansionLimit=1000000 \
  -Djdk.xml.entityReplacementLimit=2600000 \
  -Djdk.xml.totalEntitySizeLimit=40000000 \
  -Xmx1024M \
  -jar "${SAXON}" \
  -s:"${TMP_XML}" \
  -opt:10 \
  -t \
  -xsl:"${XSL}" \
  -o:"${OUT}"
echo "[+] Transforming...done"

echo "[ ] Cleaning up."
rm "${TMP_XML}"
echo "[+] Cleaning up...done"
