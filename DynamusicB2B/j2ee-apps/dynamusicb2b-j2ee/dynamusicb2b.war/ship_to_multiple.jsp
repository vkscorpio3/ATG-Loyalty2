<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/BeanProperty"/>
<dsp:importbean bean="/atg/commerce/gifts/IsGiftShippingGroup"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupFormHandler"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ShippingGroupDroplet"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- Page to determine to which address each item goes -->
<!-- Last modified: 1 May 07 by RM -->

<!-- Shipping to Multiple Address -->

<HTML>
  <HEAD>
    <TITLE>Shipping</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Ship to Multiple Addresses"/>
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

<!-- Display form errors. -->
<dsp:droplet name="Switch">
  <dsp:param bean="ShippingGroupFormHandler.formError" name="value"/>
  <dsp:oparam name="true">
    <font color=cc0000><STRONG><UL>
      <dsp:droplet name="ErrorMessageForEach">
        <dsp:param bean="ShippingGroupFormHandler.formExceptions" name="exceptions"/>
        <dsp:oparam name="output">
        <LI> <dsp:valueof param="message"/>
        </dsp:oparam>
      </dsp:droplet>
    </UL></STRONG></font><br>
  </dsp:oparam>
</dsp:droplet>
<%-- Display the Profile.defaultShippingAddress --%>
     <nobr><dsp:valueof bean="Profile.defaultShippingAddress.companyName"/></nobr><br>
     <nobr><dsp:valueof bean="Profile.defaultShippingAddress.address1"/></nobr><br>
     <dsp:droplet name="IsEmpty">
        <dsp:param name="value" bean="Profile.defaultShippingAddress.address2"/>
        <dsp:oparam name="false">
          <nobr><dsp:valueof bean="Profile.defaultShippingAddress.address2"/></nobr><br>
        </dsp:oparam>
      </dsp:droplet>    
      <dsp:valueof bean="Profile.defaultShippingAddress.city"/>,
      <dsp:valueof bean="Profile.defaultShippingAddress.state"/>
      <dsp:valueof bean="Profile.defaultShippingAddress.postalCode"/>
<p>
<font face="Verdana,Geneva,Arial" color="midnightblue" size="2">
To ship to one of your other authorized addresses, or to split your 
items among multiple shipping addresses, adjust the Shipping Address 
and/or Quantity to Move boxes below and then hit Save</font>
<p>

<table width="600" cellpadding="4"><font face="Verdana,Geneva,Arial" color="midnightblue">
<tr><td valign="bottom"><b>SKU</td><td valign="bottom"><b>Product</td><td valign="bottom"><b>Qty</td><td valign="bottom"><b>Qty to move</td><td valign="bottom"><b>Shipping Address</td><td valign="bottom"><b>Save Changes</td></tr>

<dsp:droplet name="ShippingGroupDroplet">
 
<%-- Chapter 9, Ex. 2, Steps 1, 2: Set the ShippingGroupDroplet parameters --%>


	<dsp:param name="clearShippingGroups" param="init"/>
	<dsp:param name="clearShippingInfos" param="init"/>
	<dsp:param name="initShippingGroups" param="init"/>
	<dsp:param name="initShippingInfos" param="init"/>
	<dsp:param name="initBasedOnOrder" param="fromorder"/>
	<dsp:param name="shippingGroupTypes" value="hardgoodShippingGroup"/>

  <dsp:oparam name="output">

          <dsp:droplet name="ForEach">
            <dsp:param name="array" param="order.commerceItems"/>

            <dsp:oparam name="output">
              <dsp:setvalue paramvalue="element" param="commerceItem"/>

              <!-- Set the listId property. -->
              
							<dsp:setvalue bean="ShippingGroupFormHandler.listId" paramvalue="commerceItem.id"/>

              <!-- Iterate over the CommerceItemShippingInfo objects. -->

							<dsp:droplet name="ForEach">

            	<!-- create array input parameter here -->

								<dsp:param name="array" bean="ShippingGroupFormHandler.currentList"/>
								<dsp:oparam name="output">
                  <dsp:setvalue paramvalue="element" param="cisiItem"/>

                  
<%/* Default form action is for the error case. */%>
                  <dsp:form formid="item" action="ship_to_multiple.jsp" method="post">
                   <tr valign=top>
                   
<td><nobr><dsp:valueof param="commerceItem.auxiliaryData.catalogRef.id"/></nobr></td>
                    
                   <td width="100"><dsp:a href="genericproduct.jsp?navAction=jump">
                         <dsp:param name="id" param="commerceItem.auxiliaryData.productId"/>
                         <dsp:valueof param="commerceItem.auxiliaryData.catalogRef.displayName"/></dsp:a></td> 
<%--               <td><dsp:valueof param="commerceItem.auxiliaryData.catalogRef.displayName"/></td> --%>
                   
                   <td align=right><dsp:valueof param="element.quantity"/></td>
                   
                   <td>


                     <!-- Input the split quantity. -->
											<dsp:input bean="ShippingGroupFormHandler.currentList[param:index].splitQuantity" 
											paramvalue="element.quantity" size="4" type="tex"/>



	                </td>
                   
                   <td>


                     <!-- Select the shipping group. -->

									<dsp:select bean="ShippingGroupFormHandler.currentList[param:index].splitShippingGroupName">
                     <dsp:droplet name="ForEach">
                       <dsp:param name="array" param="shippingGroups"/>
                       <dsp:oparam name="output">
                       
                         <dsp:droplet name="Switch">
                           <dsp:param name="value" param="key"/>
                           <dsp:getvalueof id="SGName" idtype="String" param="cisiItem.shippingGroupName">
                           <dsp:getvalueof id="keyname" idtype="String" param="key">
                           <dsp:oparam name="<%=SGName%>">
                             <dsp:option selected="<%=true%>" value="<%=keyname%>"/><dsp:valueof param="key"/>
                           </dsp:oparam>
                           <dsp:oparam name="default">
                             <dsp:option selected="<%=false%>" value="<%=keyname%>"/><dsp:valueof param="key"/>
                           </dsp:oparam>
                           </dsp:getvalueof>
                           </dsp:getvalueof>
                           
                         </dsp:droplet> 
                         
                        </dsp:oparam>
                     </dsp:droplet>
                     </dsp:select>
                   </td>
                   
                   <td>
                     <dsp:input bean="ShippingGroupFormHandler.splitShippingInfosSuccessURL" type="hidden" value="ship_to_multiple.jsp?init=false"/>
                     <dsp:input bean="ShippingGroupFormHandler.ListId" paramvalue="commerceItem.id" priority="<%=(int) 9%>" type="hidden"/>
                     
		     <!-- Split shipping infos. -->

										<dsp:input type="submit" bean="ShippingGroupFormHandler.splitShippingInfos" value="Save"/>
                     
                     
                   </td>
                  </tr>
                  </dsp:form>
                </dsp:oparam>
              </dsp:droplet>
            </dsp:oparam>
          </dsp:droplet>
<tr>
        <dsp:form formid="apply" action="ship_to_multiple.jsp" method="post">
          <dsp:input bean="ShippingGroupFormHandler.applyShippingGroupsSuccessURL" type="hidden" value="shipping_method.jsp"/>
<td>

          <!-- Apply shipping group information. -->

					<dsp:input type="submit" bean="ShippingGroupFormHandler.applyShippingGroups" value="Continue"/>

</td></tr>

        </dsp:form>
	</dsp:oparam>
</dsp:droplet>

</table>
</td></tr></table></font>
</BODY>
</HTML>

</dsp:page>
