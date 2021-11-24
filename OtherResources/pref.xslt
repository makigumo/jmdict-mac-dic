<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng"
                version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="no"
              doctype-public="-//W3C//DTD XHTML 1.1//EN"
              doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" />

  <xsl:param name="display-entseq">0</xsl:param>

  <xsl:template match="div[@class='entseq']">
    <xsl:if test="$display-ent-seq = '1'">
      <xsl:element name="a">
        <xsl:attribute name="class">ent_seq</xsl:attribute>
        <xsl:attribute name="href">https://www.edrdg.org/jmdictdb/cgi-bin/entr.py?svc=jmdict&amp;Ksid=&amp;q=<xsl:value-of select="."/>
        </xsl:attribute>
        <xsl:value-of select="."/>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
