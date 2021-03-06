<xsl:stylesheet version="1.0"
                xmlns:str="http://exslt.org/strings"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="vendor/escape_quotes.xsl"/>

  <xsl:output type="text"/>

  <xsl:template match="/">
    <xsl:text>rel=cannonical	title	parent	onlineItems</xsl:text><xsl:text>
</xsl:text>
    <xsl:apply-templates select="crossQueryResult/facet/group/docHit[meta/oac4-tab='Collections::ead']"/>
  </xsl:template>
  
  <xsl:template match="docHit">

    <xsl:variable name="title" select="normalize-space(meta/title[1])"/> 
    <xsl:variable name="parent" select="str:replace(meta/relation[1],'http://oac.cdlib.org/institutions/','')"/>

    <xsl:value-of select="meta/identifier[1]"/> 
    <xsl:text>	</xsl:text>
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="$title"/>
    </xsl:call-template>
    <xsl:text>	</xsl:text>
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="$parent"/>
    </xsl:call-template>
    <xsl:text>	</xsl:text>
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="boolean(meta/facet-onlineItems='Items online')"/>
    </xsl:call-template>
<xsl:if test="count(following-sibling::*) > 0">
    <xsl:text>
</xsl:text>
</xsl:if>
  </xsl:template>


</xsl:stylesheet>
