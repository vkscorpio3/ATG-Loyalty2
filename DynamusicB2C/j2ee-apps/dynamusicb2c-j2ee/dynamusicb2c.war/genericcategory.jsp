<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- storefront page to loop through rootCategories property -->
<!-- Last modified: 1 May 07 by RM -->

<!-- this is a holder page for the chapter 3, Exercise 3 -->
<!-- for creating a page to display a category -->

<!-- Title: DynamusicB2C Category Page -->




<HTML>
  <HEAD>
    <TITLE>Dynamusic Category Page</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Dynamusic Category Page"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <jsp:include page="navbar.jsp" flush="true"></jsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" color="midnightblue">

<%-- Chapter 3, Exercise 3 --%>
<%-- Insert CategoryLookup droplet --%>

<dsp:droplet name="/atg/commerce/catalog/CategoryLookup">
	<dsp:param name="id" param="id"/>
	<dsp:oparam name="output">


	<dsp:droplet name="/atg/commerce/catalog/CategoryBrowsed">
		<dsp:param name="eventobject" param="element"/>
	</dsp:droplet>


	<dsp:droplet name="/atg/commerce/catalog/CatalogNavHistoryCollector">
		<dsp:param name="navAction" param="navAction"/>
		<dsp:param name="navCount" param="navCount"/>
		<dsp:param name="item" param="element"/>
	</dsp:droplet>

	<dsp:include page="breadcrumbs.jsp" flush="true"/>

		<dsp:param name="parentCategory" param="element"/>
		<p>Category: <dsp:valueof param="parentCategory.displayName"/></p>
		
		<dsp:droplet name="/atg/dynamo/droplet/ForEach">
			<dsp:param name="array" param="parentCategory.childCategories"/>

			<dsp:oparam name="outputStart">
				Categories: <ul>		
			</dsp:oparam>

			<dsp:oparam name="output">
				<dsp:getvalueof id="templateURL" idtype="java.lang.String" param="element.Template.URL">
				<li>
					<dsp:a href="<%=templateURL%>">
						<dsp:param name="id" param="element.repositoryId"/>

						<dsp:param name="navCount" bean="/atg/commerce/catalog/CatalogNavHistory.navCount"/>
						<dsp:param name="navAction" value="push"/>

						<dsp:valueof param="element.displayName"/>
					</dsp:a>
				</li>
				</dsp:getvalueof>
			</dsp:oparam>

			<dsp:oparam name="outputEnd">
				</ul>
			</dsp:oparam>

		</dsp:droplet>


		<dsp:droplet name="/atg/dynamo/droplet/ForEach">
			<dsp:param name="array" param="parentCategory.childProducts"/>

			<dsp:oparam name="outputStart">
				Products: <ul>				
			</dsp:oparam>

			<dsp:oparam name="output">
				<dsp:getvalueof id="templateURL" idtype="java.lang.String" param="element.Template.URL">
				<li>
					<dsp:a href="<%=templateURL%>">
						<dsp:param name="id" param="element.repositoryId"/>
						<dsp:param name="navCount" bean="/atg/commerce/catalog/CatalogNavHistory.navCount"/>
						<dsp:param name="navAction" value="push"/>

						<dsp:valueof param="element.displayName"/>
					</dsp:a>
				</li>
				</dsp:getvalueof>
			</dsp:oparam>

			<dsp:oparam name="outputEnd">
				</ul>
			</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
</dsp:droplet>

</td></tr></table>
</BODY> </HTML>


</dsp:page>
