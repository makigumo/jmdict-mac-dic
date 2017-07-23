#!/bin/sh -e
SAXON=saxon9he.jar
XML=/Volumes/Data/jmdict/JMDict_e
OUT=jmdict.xml
XSL=jmdict2macos.xsl

sed 's/ENTITY \([^ ]*\) ".*"/ENTITY \1 "\1"/' ${XML} > temp.xml
java -DentityExpansionLimit=2000000 -Xmx1024M -jar ${SAXON} -s:temp.xml -opt:10 -t -xsl:${XSL} -o:${OUT}
rm temp.xml
