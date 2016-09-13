<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/SaveOrderFormHandler"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications Part I -->
<!-- Cart Page -->
<!-- Last modified: 1 May 07 by RM -->

<HTML>
  <HEAD>
    <TITLE>Dynamusic Shopping Cart</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Your Shopping Cart"/>
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
          
<%-- Chapter 7, Exercise 4, Step 3: Reprice the order when the page is loaded --%>
		<dsp:droplet name="/atg/commerce/order/purchase/RepriceOrderDroplet">
			<dsp:param name="pricingOp" value="ORDER_TOTAL"/>
		</dsp:droplet>
<%-- Chapter 7, Exercise 3, Step 1: Error Handling --%>

<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
	<dsp:param name="exceptions" bean="CartModifierFormHandler.formExceptions"/>
	<dsp:oparam name="outputStart">
		<ul>
	</dsp:oparam>
	<dsp:oparam name="output">
		<li>
			Error: <dsp:valueof param="message"/>
		</li>			
	</dsp:oparam>
	<dsp:oparam name="outputEnd">
		</ul>
	</dsp:oparam>
</dsp:droplet>



<%-- Chapter 7, Exercise 2 --%>
<%-- Loop through CommerceItems to display each Commerce Item --%>
<p>
<dsp:form method="post" action="cart.jsp">
	<dsp:droplet name="ForEach">
		<dsp:param name="array" bean="CartModifierFormHandler.order.commerceItems"/>
		<dsp:oparam name="output">
			<dsp:param name="ci" param="element"/>
			<input name='<dsp:valueof param="ci.id"/>' value='<dsp:valueof param="ci.quantity"/>' size="2">
			<dsp:valueof param="ci.auxiliaryData.catalogRef.displayName"/> <br>
			Row total price:  <dsp:valueof converter="currency" param="ci.priceInfo.rawTotalPrice"/> <br>
			Amount:  <dsp:valueof converter="currency" param="ci.priceInfo.amount"/>
			<br>
			<hr>
		</dsp:oparam>
	</dsp:droplet>


</font><p>
  <font face="Verdana,Geneva,Arial" size="+2" color="midnightblue">Shopping Cart Subtotal:</font><p>
  <font face="Verdana,Geneva,Arial" color="midnightblue">

<%-- Chapter 7, Exercise 4: Display Order Subtotal and Recalculate Button --%>
  <!-- Order Subtotal -->

	<br><dsp:valueof bean="ShoppingCart.current.priceInfo.amount" converter="currency">no price</dsp:valueof>

  <!-- Recalculate Button -->

	<br><dsp:input type="submit" bean="CartModifierFormHandler.setOrderByCommerceId" value="Recalculate"/>

<%-- Chapter 9, Exercise 1, Step 4: Test ShippingGroup Address --%>


<%-- Chapter 7, Exercise 3, Step 2: Add Checkout Button --%>
	<br>
	<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoSuccessURL" value="purchaseinfo.jsp"/>
	<dsp:input type="submit" bean="CartModifierFormHandler.moveToPurchaseInfoByCommerceId" value="Checkout"/>

</dsp:form>
<p>
<%-- Chapter 7, Optional Exercise 7: Display User's Promotions --%>




<%-- Chapter 11, Exercise 1: Create Save Order Form --%>

</font>
</td></tr>
</table>
</body>
</html>


</dsp:page>
