<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output type="text"/>

  <xsl:template match="/">
    <xsl:text>count</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>level1</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>level2</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>onlineItems</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:apply-templates 
      select="crossQueryResult/facet[@field='institution-doublelist']
              /group/group[not(substring(@value, string-length(@value))=',')]
    "/>
  </xsl:template>
  
  <xsl:template match="group">
<xsl:text>
</xsl:text>
    <xsl:value-of select="@totalDocs"/> 
    <xsl:text>	</xsl:text>
    <xsl:value-of select="@value"/> 
    <xsl:text>	</xsl:text>
    <xsl:value-of select="normalize-space(meta/title[1])"/>
    <xsl:apply-templates select="group/group[@value='onlineItems']" mode="subrepo"/>
    <xsl:apply-templates select="group" mode="subrepo"/>
  </xsl:template>

  <xsl:template match="group" mode="subrepo">
<xsl:text>
</xsl:text>
    <xsl:value-of select="@totalDocs"/> 
    <xsl:text>	</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:apply-templates select="group" mode="subrepo"/>
  </xsl:template>

  <xsl:template match="group[@value='onlineItems']" mode="subrepo">
    <xsl:text>	</xsl:text>
    <xsl:value-of select="@value"/>
  </xsl:template>

</xsl:stylesheet>
