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
            <xsl:apply-templates select="platnosc"/>
            <xsl:apply-templates select="produkty"/>
            <xsl:call-template name="data_transakcji"/>
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

    <xsl:template match="platnosc">
        <h3>Sposob platnosci:</h3>
        <xsl:apply-templates select="przy_odbiorze|online"/>
    </xsl:template>

    <xsl:template match="przy_odbiorze">
        Przy odbiorze: <b><xsl:value-of select="./forma_platnosci"/></b>
    </xsl:template>

    <xsl:template match="online">
        Przy odbiorze: <b><xsl:value-of select="./forma_platnosci"/></b>
    </xsl:template>

    <xsl:template match="produkty">
        <h3>Produkty:</h3>
        <h4>Sprzegla:</h4>
        <xsl:for-each select="sprzeglo">
            <xsl:sort select="moment"/>
            <div>
                <xsl:variable name="nr_kat" select="./@nr_kat"/>
                <h4><xsl:number value="position()" format="1. "/>Nr katalogowy: <b><xsl:value-of select="$nr_kat"/></b></h4>
                <xsl:call-template name="sprzeglo"/>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="sprzeglo">
        Producent: <xsl:apply-templates select="producent"/><br/>
                <xsl:for-each select="kod_silnika">
                <xsl:number count="bmwparts/transakcja/produkty/sprzeglo/kod_silnika" format="1. "/>
                <b>Kod silnika: </b><xsl:value-of select="."/><br/>
                </xsl:for-each>
                <xsl:for-each select="kod_skrzyni">
                <xsl:number count="bmwparts/transakcja/produkty/sprzeglo/kod_skrzyni" format="1. "/>
                <b>Kod skrzyni: </b><xsl:value-of select="."/><br/>
                </xsl:for-each>
                <b>Kod modelu: </b><xsl:apply-templates select="kod_modelu"/><br/>
                <b>Moment: </b><xsl:value-of select="moment"/><br/>
                <b>Srednica: </b><xsl:value-of select="srednica"/><br/>
                <b>Cena: </b><xsl:value-of select='format-number(cena, "####.00 PLN")'/><br/>
        <div><b>Zdjecie: </b><xsl:apply-templates select="zdjecie"/><br/><br/><br/></div>        
    </xsl:template>

    <xsl:template match="producent">
        <b><xsl:value-of select="./nazwa_handlowa"/></b><br/>
        <xsl:value-of select="./ulica_nr"/><br/>
        <xsl:value-of select="./kod"/><b>&#160;</b>
        <xsl:value-of select="./miasto"/><br/>
        <xsl:apply-templates select="link"/><br/>
    </xsl:template>

    <xsl:template match="kod_skrzyni">
        <xsl:value-of select="."/><b>&#160;&#160;&#160;</b>
    </xsl:template>

    <xsl:template match="zdjecie">
        <br/>
        <xsl:element name="img">
            <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
            <xsl:attribute name="height">200</xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template name="data_transakcji">
        <b>Data transakcji: </b><xsl:apply-templates select="./@data"/><br/>
    </xsl:template>

    <xsl:template match="@data">
        <xsl:choose>
            <xsl:when test="string-length()=10">
                <i><xsl:value-of select="."/></i>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./@href"/>
            </xsl:attribute>
            <xsl:value-of select="."/><br/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>