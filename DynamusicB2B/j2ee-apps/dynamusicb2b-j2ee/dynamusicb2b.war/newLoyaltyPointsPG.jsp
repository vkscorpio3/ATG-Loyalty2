<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/ComponentExists"/>
<dsp:importbean bean="/loyalty/order/CreateLoyaltyPointsPGFormHandler"/>
<HTML>
  <HEAD>
    <TITLE>New Loyalty Points Group</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="New Loyalty Points Group"/>
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


		  <p>Enter new LoyaltyPointsGroup information
		  
		  <dsp:droplet name="PaymentGroupDroplet">
	<dsp:param name="clearPaymentGroups" param="init"/>
	<dsp:param name="initPaymentGroups" param="init"/>
	<dsp:param name="paymentGroupTypes" value="creditCard,loyaltyPoints"/>
	<dsp:param name="clearPaymentInfos" value="true"/>
	<dsp:param name="initOrderPayment" value="true"/>
</dsp:droplet>

<dsp:form action="newLoyaltyPointsPG.jsp" method="post">

<br>LoyaltyPoints Group Name:<dsp:input bean="CreateLoyaltyPointsPGFormHandler.loyaltyPointsPGName" size="30" type="text" value=""/>
<br><dsp:input type="hidden" bean="CreateLoyaltyPointsPGFormHandler.loyaltyPointsPG.userId" beanvalue="Profile.id"/>
<br><dsp:input type="hidden" bean="CreateLoyaltyPointsPGFormHandler.loyaltyPointsPG.points" beanvalue="Profile.loyaltyAmount"/>


<dsp:input bean="CreateLoyaltyPointsPGFormHandler.createLoyaltyPointsPG" type="submit" value="Enter Loyalty Points Group"/>

</dsp:form>

         </font>
       </td>
      </tr>
    </table>




</body>
</html>
</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/DynamusicB2B/j2ee-apps/dynamusicb2b-j2ee/dynamusicb2b.war/credit_card.jsp#9 $$Change: 514668 $--%>
