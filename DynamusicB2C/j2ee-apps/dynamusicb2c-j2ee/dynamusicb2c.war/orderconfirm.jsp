<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- page to review and confirm order -->
<!-- Last modified: 11 Apr 06 by KL -->

<!-- Title: Order Confirm -->

<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/commerce/order/purchase/ExpressCheckoutFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<HTML>
  <HEAD>
    <TITLE>Dynamusic Order Confirmation</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Order Confirmation"/>
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



<!-- Error handling -->
<dsp:droplet name="/atg/dynamo/droplet/Switch">
<dsp:param bean="ExpressCheckoutFormHandler.formError" name="value"/>
<dsp:oparam name="true">
  <font color=cc0000><STRONG><UL>
    <dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
      <dsp:param bean="ExpressCheckoutFormHandler.formExceptions" name="exceptions"/>
      <dsp:oparam name="output">
	<LI> <dsp:valueof param="message"/>
      </dsp:oparam>
    </dsp:droplet>
    </UL></STRONG></font>
</dsp:oparam>
</dsp:droplet>

<%-- Ch. 8, Ex. 1, Step 1: Display order pricing information --%>
  <b>Subtotal:</b>   <dsp:valueof converter="currency" bean="ShoppingCart.current.priceInfo.amount"/><br>
  <b>Shipping:</b>  <dsp:valueof converter="currency" bean="ShoppingCart.current.priceInfo.shipping"/> <br>
  <b>Total:</b> <dsp:valueof converter="currency" bean="ShoppingCart.current.priceInfo.total"/>
<p>

<!-- Enter form with confirm order button here -->
<dsp:form action="orderconfirm.jsp" method="post">
	Click the button to confirm the order <br>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.commitOrder" value="true"/>
	<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.expressCheckoutSuccessURL" value="orderstatus.jsp"/>
	<dsp:input type="submit" bean="ExpressCheckoutFormHandler.expressCheckout" value="Express Checkout"/>
</dsp:form>
</font></td></tr></table>
</body>
</html>

</dsp:page>
