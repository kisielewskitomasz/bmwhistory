<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <meta name="author" content="Tomasz Kisielewski" />
                <meta name="description" content="BMW PARTS - największa hurtownia części do wszystkich modeli BMW!" />
                <meta name="keywords" content="BMW, Seria 3, E21, E30, E36, E46, E90, Seria 5, E12, E28, E34, E39, E60, Seria 7, E23, E32, E38, E65, F01, części, parts, część, hurtownia" />
                <title>BMW PARTS - wszystko do Twojego BMW</title>
                <link rel="shortcut icon" href="img/icon.ico" />
                <link rel="stylesheet" href="css/style.css" />
            </head>

            <body>
                <div>
                    <center>
                        <xsl:element name="img">
                            <xsl:attribute name="src">img/bmwparts.png</xsl:attribute>
                            <xsl:attribute name="width">1000</xsl:attribute>
                            <xsl:attribute name="height">250</xsl:attribute>
                        </xsl:element>
                    </center>
                <h1>
                    <center>BMW PARTS</center>
                </h1>
                </div>
                <div>
                <h2>
                    <center>Klienci (<xsl:value-of select="count(bmwparts/transakcja/kupujacy)"/>)</center>
                </h2>
                    <xsl:apply-templates select="bmwparts/transakcja"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="transakcja">
        <div style="width:500px; height:auto;float:left">
            <hr/>
            <xsl:apply-templates select="kupujacy"/>
        </div>
    </xsl:template>

    <xsl:template match="kupujacy">
        <h3>Zamawiajacy:</h3>
        <xsl:choose>
            <xsl:when test="@firma='tak'">
                <b>Firma: </b><xsl:value-of select="./nazwa_firmy"/><br/>
                <b>NIP: </b><xsl:value-of select="./nip"/><br/>
            </xsl:when>
            <xsl:otherwise>
                <br/><b>Osoba prywatna</b><br/>
            </xsl:otherwise>
        </xsl:choose>
        <b>Imie: </b><xsl:value-of select="./imie"/><br/>
        <b>Nazwisko: </b><xsl:value-of select="./nazwisko"/><br/>
        <b>Ulica: </b><xsl:value-of select="./ulica_nr"/><br/>
        <b>Kod pocztowy: </b><xsl:value-of select="./kod"/><br/>
        <b>Miasto: </b><xsl:value-of select="./miasto"/><br/>
        <b>Telefon: </b><xsl:value-of select="./telefon"/><br/>
        <xsl:choose>
            <xsl:when test="@firma='tak'">
                <b>Rabat: </b>10%<br/>
            </xsl:when>
            <xsl:otherwise>
                <b>Rabat: </b>brak<br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>