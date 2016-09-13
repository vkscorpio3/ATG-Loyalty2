<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- storefront page to loop through rootCategories property -->
<!-- Last modified: 1 May 07 by RM -->

<!-- this is a holder page for the chapter 3 labs -->

<!-- Title: DynamusicB2C Storefront -->

<HTML>
  <HEAD>
    <TITLE>Dynamusic Store</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Dynamusic Store"/>
    </dsp:include>
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <dsp:include page="navbar.jsp">
          </dsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" size="+1" color="midnightblue">

<%-- Chapter 3, Exercise 1: Create a Front Page for Your Catalog --%>
<%-- Insert TargetingForEach to loop through RootCategories below this line --%>

<dsp:droplet name="/atg/targeting/TargetingForEach">
	<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/ProductCatalog/RootCategories"/>
	<dsp:oparam name="output">
		<dsp:getvalueof id="templateURL" idtype="java.lang.String" param="element.Template.URL">
		<p>
			<dsp:a href="<%=templateURL%>">
				<dsp:param name="id" param="element.repositoryId"/>
				<dsp:param name="navAction" value="jump"/>
				<dsp:param name="navCount" bean="/atg/commerce/catalog/CatalogNavHistory.navCount"/>

				<dsp:valueof param="element.displayName"/>
			</dsp:a>
		</p>
		</dsp:getvalueof>
	</dsp:oparam>
</dsp:droplet>

<%-- End: TargetingForEach --%>

          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>


</dsp:page>
