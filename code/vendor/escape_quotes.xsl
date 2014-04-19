<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- 

  http://www.cygwin.com/ml/xsl-list/2001-03/msg00794.html archive of xsl-list@mulberrytech.com
  Copyright © 2001 Unidex, Inc. All rights reserved.
<sig name    = 'Bob Lyons'
     title   = 'E-Commerce Consultant'
     company = 'Unidex, Inc.'
     phone   = '+1-732-975-9877'
     email   = 'boblyons@unidex.com'
     url     = 'http://www.unidex.com/'
     product = 'XML Convert: transforms flat files to XML and vice versa' />

  -->

  <xsl:template name="display_csv_field">
    <xsl:param name="field"/>
    <xsl:variable name="linefeed">
      <xsl:text>&#10;</xsl:text>
    </xsl:variable>


    <xsl:choose>
    <xsl:when test="contains( $field, '&quot;' )">
      <!-- Field contains a quote. We must enclose this field in quotes,
           and we must escape each of the quotes in the field value.
      -->
      <xsl:text>"</xsl:text>

      <xsl:call-template name="escape_quotes">
        <xsl:with-param name="string" select="$field" />
      </xsl:call-template>

      <xsl:text>"</xsl:text>
    </xsl:when>

    <xsl:when test="contains( $field, ',' ) or
                    contains( $field, $linefeed )" >
      <!-- Field contains a comma and/or a linefeed.
           We must enclose this field in quotes.
      -->
      <xsl:text>"</xsl:text>
      <xsl:value-of select="$field" />
      <xsl:text>"</xsl:text>
    </xsl:when>

    <xsl:otherwise>
      <!-- No need to enclose this field in quotes.
      -->
      <xsl:value-of select="$field" />
    </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <xsl:template name="escape_quotes">
    <xsl:param name="string" />

    <xsl:value-of select="substring-before( $string, '&quot;' )" />
    <xsl:text>""</xsl:text>

    <xsl:variable name="substring_after_first_quote"
                  select="substring-after( $string, '&quot;' )" />

    <xsl:choose>

    <xsl:when test="not( contains( $substring_after_first_quote, '&quot;' ) )">
      <xsl:value-of select="$substring_after_first_quote" />
    </xsl:when>

    <xsl:otherwise>
      <!-- The substring after the first quote contains a quote.
           So, we call ourself recursively to escape the quotes
           in the substring after the first quote.
      -->

      <xsl:call-template name="escape_quotes">
        <xsl:with-param name="string" select="$substring_after_first_quote" />
      </xsl:call-template>
    </xsl:otherwise>

    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
