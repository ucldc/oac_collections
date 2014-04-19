<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output type="text"/>

  <xsl:template match="/">
    <xsl:apply-templates select="crossQueryResult/facet/group/docHit[meta/oac4-tab='Collections::ead']"/>
  </xsl:template>
  
  <xsl:template match="docHit">
    <xsl:value-of select="meta/identifier[1]"/> 
    <xsl:text>	</xsl:text>
    <xsl:value-of select="normalize-space(meta/title[1])"/> 
<xsl:if test="count(following-sibling::*) > 0">
    <xsl:text>
</xsl:text>
</xsl:if>
  </xsl:template>


</xsl:stylesheet>
