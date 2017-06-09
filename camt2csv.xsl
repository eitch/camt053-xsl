<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (C) 2012, Daniel Pocock http://danielpocock.com -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:camt="urn:iso:std:iso:20022:tech:xsd:camt.053.001.04">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:strip-space elements="*" />

<xsl:template match="/camt:Document/camt:BkToCstmrStmt/camt:GrpHdr">
  <xsl:if test="camt:MsgPgntn/camt:PgNb != 1 or camt:MsgPgntn/camt:LastPgInd != 'true'">
    <xsl:message terminate="yes">
      <xsl:text>Incomplete message (not first page or subsequent pages exist)</xsl:text>
    </xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template match="/camt:Document/camt:BkToCstmrStmt/camt:Stmt">
<xsl:for-each select="camt:Ntry">

	<xsl:variable name="bookingDate" select="camt:BookgDt/camt:Dt" />
	<xsl:variable name="valDate" select="camt:ValDt/camt:Dt" />
	<xsl:variable name="ref" select="camt:AcctSvcrRef" />
	<xsl:variable name="info" select="camt:AddtlNtryInf" />

	<xsl:for-each select="camt:NtryDtls/camt:TxDtls">
		<xsl:copy-of select="$bookingDate"/>,<xsl:copy-of select="$valDate"/>,"<xsl:copy-of select="$ref"/>","<xsl:value-of select="camt:Refs/camt:AcctSvcrRef"/>","<xsl:value-of select="camt:RmtInf/camt:Ustrd"/>",<xsl:if test="camt:CdtDbtInd = 'DBIT'">-</xsl:if><xsl:value-of select="camt:Amt"/>,"<xsl:copy-of select="$info"/>"<xsl:text>&#xD;&#xA;</xsl:text>
	</xsl:for-each>

</xsl:for-each>
</xsl:template>

<xsl:template match="/"><xsl:apply-templates select="/camt:Document/camt:BkToCstmrStmt/camt:GrpHdr|/camt:Document/camt:BkToCstmrStmt/camt:Stmt"/></xsl:template>

</xsl:stylesheet>
