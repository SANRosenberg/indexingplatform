<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ns1="dda.dk/metadata/1.0.0" 
    xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
    xmlns:ddi-cv="urn:ddi-cv" exclude-result-prefixes="ns1 gc ddi-cv">
    
    <xsl:variable name="studyId" select="substring-after(ns1:Study/ns1:StudyIdentifier/ns1:Identifier, 'dda')" />
    <xsl:variable name="labels" select="document('lp-labels.xml')"/>
    <xsl:variable name="accessConditionsCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/accessconditions.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="accessRestrictionsCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/accessrestrictions.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="dataCollectionMethodCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/datacollectionmethodology.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="dataCollectionModeCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/datacollectionmode.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="kindOfDataCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/kindofdata.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="samplingprocedureCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/samplingprocedure.dda.dk-1.0.0.cv')"/>
    <xsl:variable name="studyStateCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/studystate.dda.dk.1.0.0.cv')"/>
    <xsl:variable name="timeMethodCV" select="document('xmldb:exist:///db/apps/dda/transform/landingpage/cv/timemethod.dda.dk-1.0.0.cv')"/>
    
    <xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyzæøå'"/>    
    <xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ'"/> 
    
    <xsl:template name="lp-core-content">
     <xsl:param name="lang" />
        <div itemscope="itemscope" itemtype="http://schema.org/Dataset">
        <h1 class="lp">
            <span itemprop="name">
            <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>
            </span>
        </h1>
        <a name="primaryinvestigator"/>
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='principalinvestigator']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <xsl:for-each select="ns1:PrincipalInvestigators/ns1:PrincipalInvestigator">
            <div itemscope="itemscope" itemtype="http://schema.org/Person">
                <span itemprop="name"><xsl:value-of select="ns1:Person/ns1:FirstName/text()"/></span>, 
                <xsl:value-of select="ns1:Person/ns1:Affiliation/ns1:AffiliationName"/>
            </div>
        </xsl:for-each>
        <a name="documentation"></a>
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='documentation']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <p class="lp">           
            <a href="{ concat($studyId, '/documentation/codebook/dda-',  $studyId, '.html')}">Kodebog</a> (variabler, universer, koncepter, surveydesign og frekvensfordeling)<br />																																	
        </p>
        <p class="lp">
            <a href="{ concat($studyId, '/documentation/questionaire/q-',  $studyId, '.pdf')}">Spørgeskema PDF</a>
        </p>	
        <a name="description"/>
            <h2 class="lp"><xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='description']/LabelText[@xml:lang=$lang]/text()"
            /></h2> <h3 class="lp"><xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='purpose']/LabelText[@xml:lang=$lang]/text()"
            />
            </h3><xsl:value-of
                select="ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='purpose']/ns1:Content[@xml:lang=$lang]/text()"/>
            <h3 class="lp">
            <xsl:value-of select="$labels/LandingPageLabels/Label[@id='abstract']/LabelText[@xml:lang=$lang]/text()" />
        </h3>
        <span itemprop="description">
            <xsl:value-of
                select="ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='abstract']/ns1:Content[@xml:lang=$lang]/text()"
            />
        </span>
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='keywords']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3> <span class="lplink">
            <xsl:for-each select="ns1:TopicalCoverage/ns1:Keywords/ns1:Keyword">
                <a href="#">
                    <span itemprop="keyword">
                        <span itemscope="itemscope" itemtype="http://schema.org/Text"><xsl:value-of select="text()"/></span>,
                    </span>
                </a>
            </xsl:for-each>
        </span>
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='classification']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3>
        <span class="lplink">
            <xsl:for-each select="ns1:TopicalCoverage/ns1:Subjects/ns1:Subject">                
                <a href="#">
                    <span itemprop="about">
                        <xsl:value-of select="concat(text(), ', ')"/>
                    </span>
                </a>                
            </xsl:for-each>
        </span>
        <a name="universe"></a> 
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='universe']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2> <xsl:value-of select="ns1:Universes/ns1:Universe/ns1:Label[@xml:lang=$lang]/text()"/>, <em>
             <xsl:value-of select="ns1:Universes/ns1:Universe/ns1:Description[@xml:lang=$lang]/text()"/></em>
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='geographiccoverage']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3>
        <!-- todo: http://dbpedia.org/resource/Denmark -->        
        <xsl:value-of select=
            "concat(translate(substring(ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Label,1,1), $vLower, $vUpper),
            substring(ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Label, 2),
            substring(' ', 1 div not(position()=last())))
        "/> 
            <xsl:if test="ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Description[@xml:lang=$lang]">
                , <em>
                    <xsl:value-of select="ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Description[@xml:lang=$lang]/text()"/>
                </em>
            </xsl:if>
        <a name="dataset"></a> 
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='dataset']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <p class="lp">	
            <a href="#">
                <xsl:value-of
                    select="$labels/LandingPageLabels/Label[@id='askfordata']/LabelText[@xml:lang=$lang]/text()"
                />
            </a><br /> 
        </p>
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='variables']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />  
         </strong>
        <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:NumberVariables"/>
        <br />
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='respondenter']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3>
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='respondenter_numberunits']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />
        </strong>
        <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:NumberUnits"/>
        <br />
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='respondenter_samplenumberunits']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />
        </strong>
        <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:SampleNumberOfUnits"/>        
        <a name="method"></a>												
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='method']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='studytype']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />                
            </strong>
            <xsl:variable name="kindOfDataId" select="ns1:Methodolody/ns1:DataType/ns1:DataTypeIdentifier" />
            <xsl:value-of select="$kindOfDataCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$kindOfDataId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>     
        </p>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='testtype']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />    
            </strong>
            <xsl:variable name="methodologyId" select="ns1:Methodology/ns1:TestType/ns1:TestTypeIdentifier" />
            <xsl:value-of select="$dataCollectionMethodCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$methodologyId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>   
            <br />
        </p>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='timemethod']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />                
            </strong>
            <xsl:variable name="timeMethodId" select="ns1:Methodology/ns1:TimeMethod/ns1:TimeMethodIdentifier" />
            <xsl:value-of select="$timeMethodCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$timeMethodId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>       
            <br />
        </p>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='samplingprocedure']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />  
            </strong>
            <xsl:variable name="samplingProcedureId" select="ns1:DataCollection/ns1:SamplingProcedure/ns1:SamplingProcedureIdentifier" />
            <xsl:value-of select="$samplingprocedureCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$samplingProcedureId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>       
            <br />
        </p>
        <p class="lp">        
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='numberofquestions']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />                
            </strong>           
            <xsl:value-of select="ns1:Methodology/ns1:NumberOfQuestions"/>
        </p>
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='datacollection']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='modeofcollection']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />  
            </strong>
            <xsl:variable name="modeOfCollectionId" select="ns1:DataCollection/ns1:ModeOfCollection/ns1:ModeOfCollectionIdentifier" />
            <xsl:value-of select="$dataCollectionModeCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$modeOfCollectionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>       
            <br />
        </p>
        <p class="lp">
            <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='datacollector']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />  
            </strong>
            <xsl:value-of select="ns1:DataCollection/ns1:DataCollectorOrganizationReference"/>
            <br />
        </p>
        <span itemprop="temporal">
            <h3 class="lp">
                <xsl:value-of
                    select="$labels/LandingPageLabels/Label[@id='temporalcoverage']/LabelText[@xml:lang=$lang]/text()"
                />
            </h3>
            <strong class="lp">            
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='temporalcoverage_startdate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />
            </strong>
            <span itemprop="startDate">
                <xsl:value-of select="ns1:TemporalCoverages/ns1:TemporalCoverage/ns1:StartDate"/>
            </span>
            <br />
            <strong class="lp"> 
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='temporalcoverage_enddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />
            </strong>
            <span itemprop="endDate">
                <xsl:value-of select="ns1:TemporalCoverages/ns1:TemporalCoverage/ns1:EndDate"/>
            </span>
        </span>
        <br />
        <a name="citation"></a>
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='citation']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <xsl:value-of select="concat(ns1:PrincipalInvestigators/ns1:PrincipalInvestigator/ns1:Person/ns1:FirstName, ', ')" />
            <em><xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>, </em> 
            <xsl:value-of select="ns1:Archive"/>, <xsl:value-of select="substring-before(ns1:PublicationDate, '-')"/>. 1 datafil: 
            <xsl:value-of select="concat('DDA-', $studyId)"/>, version: <xsl:value-of select="ns1:StudyIdentifier/ns1:CurrentVersion"/>, 
            <a href="#">doi:10.5072/<xsl:value-of select="concat('DDA-', $studyId)"/></a>            
        <h3 class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='persistentidentifier']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />             
        </h3>													
        <p class="lp">
            <strong class="lp">URL: </strong><a href="#">http://dda.dk/catalogue/<xsl:value-of select="$studyId"/></a><br />
        </p>
        <p class="lp">
            <strong class="lp">DOI: </strong><a href="#">doi:10.5072/<xsl:value-of select="concat('DDA-', $studyId)"/></a> 
        </p>
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='archiveinfo']/LabelText[@xml:lang=$lang]/text()"
            />   
        </h3><strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='recieveddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                />
            </strong>
            <xsl:value-of select="'todo: value missing from metadata?'"/>
            <br />
             <strong class="lp">
                <xsl:value-of
                    select="concat($labels/LandingPageLabels/Label[@id='publisheddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
            </strong>
            <span itemprop="datePublished">
                <xsl:value-of select="substring-before(ns1:PublicationDate/text(), 'T')"/>
            </span>
            
        <a name="status"></a>
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='access']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='studystate']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />
        </strong>
        <xsl:variable name="stateId" select="ns1:State" />
        <xsl:value-of select="$studyStateCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$stateId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
        <br />
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='restrictions']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />
        </strong>
        <xsl:variable name="restrictionId" select="ns1:Access/ns1:Restriction" />
        <xsl:value-of select="$accessRestrictionsCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$restrictionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
        <br />											
        <strong class="lp">
            <xsl:value-of
                select="concat($labels/LandingPageLabels/Label[@id='accessconditions']/LabelText[@xml:lang=$lang]/text(), ': ')"
            />
        </strong>
        <xsl:variable name="conditionId" select="ns1:Access/ns1:Condition" />
        <xsl:value-of select="$accessConditionsCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$conditionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
        <br />
            
        <!-- todo: contruct metedata -->
        <a name="metadata"></a>													
        <h2 class="lp">Metadata</h2>
            <p class="lp">
                <a href="{ concat($studyId, '/metadata/ddi-3.1/dda-',  $studyId, '.xml')}">DDI-L-3.1 XML Studiemetadata </a><br />																								
            </p>
            <p class="lp">
                <a href="#">DDA XML Studiebeskrivelse</a><br />											
            </p>
            <!--a href="#">DublinCore</a><br-->																				
            <p class="lp">
                <a href="#">DataCite XML mf.</a><br />											
            </p>
            <!--a href="#">MARC</a-->				
        </div>
    </xsl:template>
</xsl:stylesheet>
