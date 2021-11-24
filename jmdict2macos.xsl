<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output omit-xml-declaration="no"
                encoding="UTF-8"
                method="xml"/>

    <xsl:template match="/">
        <xsl:processing-instruction name="xml-stylesheet">
            <xsl:text>type="text/css" href="jmdict.css"</xsl:text>
        </xsl:processing-instruction>
        <d:dictionary xmlns="http://www.w3.org/1999/xhtml"
                      xmlns:d="http://www.apple.com/DTDs/DictionaryService-1.0.rng">

            <xsl:apply-templates/>
        </d:dictionary>
    </xsl:template>

    <xsl:template match="entry">

        <xsl:variable name="title">
            <xsl:choose>
                <xsl:when test="k_ele">
                    <xsl:apply-templates select="k_ele"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="r_ele"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <d:entry id="{ent_seq}" d:title="{$title}">
            <!-- get indexes -->
            <xsl:variable name="idx">
                <xsl:call-template name="index">
                    <xsl:with-param name="index_title" select="$title"/>
                </xsl:call-template>
            </xsl:variable>
            <!-- filter index duplicates -->
            <xsl:for-each select="$idx">
                <xsl:copy-of select="d:index[not(preceding-sibling::d:index/@d:value=./@d:value
                 and preceding-sibling::d:index/@d:title=./@d:title and preceding-sibling::d:index/@d:yomi=./@d:yomi)]"/>
            </xsl:for-each>

            <!-- content -->
            <div class="entry">

                <xsl:choose>
                    <xsl:when test="k_ele">
                        <h1>
                            <xsl:apply-templates select="k_ele"/>
                        </h1>
                        <h2>
                            <xsl:apply-templates select="r_ele"/>
                        </h2>
                    </xsl:when>
                    <xsl:otherwise>
                        <h1>
                            <xsl:apply-templates select="r_ele"/>
                        </h1>
                    </xsl:otherwise>
                </xsl:choose>

                <ol class="senses">
                    <xsl:apply-templates select="sense"/>
                </ol>

            </div>
        </d:entry>
    </xsl:template>

    <!--
    Index
    -->
    <xsl:template name="index">
        <xsl:param name="index_title"/>
        <xsl:choose>
            <!-- all kanji reading pairs -->
            <xsl:when test="k_ele">
                <xsl:for-each select="k_ele">
                    <xsl:variable name="keb" select="keb"/>
                    <xsl:for-each select="../r_ele/reb">
                        <d:index d:title="{$index_title}" d:value="{$keb}" d:yomi="{.}"/>
                        <d:index d:title="{$keb}" d:value="{$keb}" d:yomi="{.}"/>
                        <d:index d:title="{$keb}" d:value="{.}"/>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:when>
            <!-- all readings -->
            <xsl:otherwise>
                <xsl:for-each select="r_ele">
                    <d:index d:title="{$index_title}" d:value="{reb}"/>
                    <d:index d:title="{reb}" d:value="{reb}"/>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="k_ele">
        <xsl:apply-templates select="keb"/>
        <xsl:if test="following-sibling::k_ele">
            <xsl:text>; </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="r_ele">
        <xsl:apply-templates select="reb"/>
        <xsl:if test="re_restr">
            <ul class="re_restrs">
                <xsl:apply-templates select="re_restr"/>
            </ul>
        </xsl:if>
        <xsl:if test="following-sibling::r_ele">
            <xsl:text>; </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="sense">
        <li class="sense">
            <xsl:if test="stagk">
                <ul class="stagks">
                    <xsl:apply-templates select="stagk"/>
                </ul>
            </xsl:if>
            <xsl:if test="stagr">
                <ul class="stagrs">
                    <xsl:apply-templates select="stagr"/>
                </ul>
            </xsl:if>
            <xsl:if test="pos">
                <ul class="poses">
                    <xsl:apply-templates select="pos"/>
                </ul>
            </xsl:if>
            <xsl:if test="xref">
                <ul class="xrefs">
                    <xsl:apply-templates select="xref"/>
                </ul>
            </xsl:if>
            <xsl:if test="ant">
                <ul class="ants">
                    <xsl:apply-templates select="ant"/>
                </ul>
            </xsl:if>
            <xsl:if test="field">
                <ul class="fields">
                    <xsl:apply-templates select="field"/>
                </ul>
            </xsl:if>
            <xsl:if test="misc">
                <ul class="miscs">
                    <xsl:apply-templates select="misc"/>
                </ul>
            </xsl:if>
            <xsl:if test="s_inf">
                <ul class="s_infs">
                    <xsl:apply-templates select="s_inf"/>
                </ul>
            </xsl:if>
            <xsl:if test="lsource">
                <ul class="lsources">
                    <xsl:apply-templates select="lsource"/>
                </ul>
            </xsl:if>
            <xsl:if test="dial">
                <ul class="dials">
                    <xsl:apply-templates select="dial"/>
                </ul>
            </xsl:if>
            <ol class="glosses">
                <xsl:apply-templates select="gloss"/>
            </ol>
        </li>
    </xsl:template>

    <xsl:template match="re_restr">
        <li class="re_restr">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="gloss">
        <li class="gloss">
            <xsl:if test="@g_type">
                <xsl:apply-templates select="@g_type"/>
            </xsl:if>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="gloss/@g_type">
        <span class="gloss_type">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <xsl:template match="stagk">
        <li class="stagk">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="stagr">
        <li class="stagr">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="pos">
        <li class="pos">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="xref">
        <li class="xref">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="ant">
        <li class="ant">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="misc">
        <li class="misc">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="field">
        <li class="field">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="s_inf">
        <li class="s_inf">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="lsource">
        <li class="lsource">
            <xsl:if test="@xml:lang">
                <span class="lang">
                    <xsl:value-of select="@xml:lang"/>
                </span>
            </xsl:if>
            <xsl:if test="@ls_type = 'part' and following-sibling::lsource[@ls_type]">
                <xsl:text> + </xsl:text>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@ls_wasei = 'y'">
                    <span class="wasei">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>

        </li>
    </xsl:template>

    <xsl:template match="dial">
        <li class="dial">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

  <!-- custom expanded entity content -->
  <xsl:template match="ent">
    <span class="entity" title="{@tit}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>
