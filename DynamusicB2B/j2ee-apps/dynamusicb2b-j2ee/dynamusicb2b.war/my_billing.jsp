<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<declareparam name="init" CLASS="java.lang.String" DESCRIPTION="init variable sent to page"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet"/>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentAddressFormHandler"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>


<HTML>
  <HEAD>
    <TITLE>Billing</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Billing"/>
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


<dsp:droplet name="/atg/dynamo/droplet/Switch">
  <dsp:param param="init" name="value"/>
  <dsp:oparam name="unset">
  
      <dsp:droplet name="/atg/dynamo/droplet/Switch">
      <dsp:param bean="Profile.creditCardAuthorized" name="value"/>
      <dsp:oparam name="true">
		<dsp:include page="billing_cc.jsp" flush="false"><dsp:param name="init" value="true"/></dsp:include>
			<dsp:a href="credit_card.jsp=false">Add Credit Card</dsp:a><br>
		   <dsp:a href="newLoyaltyPointsPG.jsp?init=false">Add Loyalty Points Group</dsp:a>
      </dsp:oparam>
      <dsp:oparam name="false">
      Sorry, you cannot pay, cause you do not have any payment methods.
      </dsp:oparam>
    </dsp:droplet>

  </dsp:oparam>

 <dsp:oparam name="default">
 
        <dsp:droplet name="/atg/dynamo/droplet/Switch">
         <dsp:param bean="Profile.creditCardAuthorized" name="value"/>
         <dsp:oparam name="false">
           Sorry, you cannot pay, cause you do not have any payment methods.
         </dsp:oparam>
         <dsp:oparam name="true">
           <dsp:getvalueof id="pval0" param="init"><dsp:include page="billing_cc.jsp" flush="false"><dsp:param name="init" value="<%=pval0%>"/></dsp:include></dsp:getvalueof>
		   <dsp:a href="credit_card.jsp=false">Add Credit Card</dsp:a><br>
		   <dsp:a href="newLoyaltyPointsPG.jsp?init=false">Add Loyalty Points Group</dsp:a>
         </dsp:oparam>
       </dsp:droplet>
  </dsp:oparam>
</dsp:droplet>
         </font>
       </td>
      </tr>
    </table>




</body>
</html>
</dsp:page>