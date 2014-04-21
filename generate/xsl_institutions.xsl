<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="vendor/escape_quotes.xsl"/>

  <xsl:output type="text"/>

  <xsl:template match="/">
    <xsl:text>count</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>level1</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>level2</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:text>onlineItems</xsl:text>
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
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="@value"/>
    </xsl:call-template>
    <xsl:text>	</xsl:text>
    <xsl:text>""</xsl:text>
    <xsl:if test="not(group/group[@value='onlineItems'] or group[@value='onlineItems'])">
      <xsl:text>	""</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="(group/group[@value='onlineItems'])[1]" mode="subrepo"/>
    <xsl:apply-templates select="group" mode="subrepo"/>
  </xsl:template>

  <xsl:template match="group" mode="subrepo">
<xsl:text>
</xsl:text>
    <xsl:value-of select="@totalDocs"/> 
    <xsl:text>	</xsl:text>
    <xsl:text>""</xsl:text>
    <xsl:text>	</xsl:text>
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="@value"/>
    </xsl:call-template>
    <xsl:if test="not(group[@value='onlineItems'])">
      <xsl:text>	""</xsl:text>
    </xsl:if>
    <xsl:apply-templates select="group" mode="subrepo"/>
  </xsl:template>

  <xsl:template match="group[@value='onlineItems']" mode="subrepo">
    <xsl:text>	</xsl:text>
    <xsl:call-template name="display_csv_field">
      <xsl:with-param name="field" select="@value"/>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
