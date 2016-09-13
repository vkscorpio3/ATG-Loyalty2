<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/commerce/order/purchase/CreateCreditCardFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/ComponentExists"/>
<HTML>
  <HEAD>
    <TITLE>New Credit Card</TITLE>
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


		  <p>Enter new CreditCard information
		  
		  <dsp:droplet name="PaymentGroupDroplet">
	<dsp:param name="clearPaymentGroups" param="init"/>
	<dsp:param name="initPaymentGroups" param="init"/>
	<dsp:param name="paymentGroupTypes" value="creditCard,loyaltyPoints"/>
	<dsp:param name="clearPaymentInfos" value="true"/>
	<dsp:param name="initOrderPayment" value="true"/>
</dsp:droplet>

<dsp:form action="credit_card.jsp" method="post">

<br>CreditCard NickName:<dsp:input bean="CreateCreditCardFormHandler.creditCardName" size="30" type="text" value=""/>
<br>CreditCardNumber:<dsp:input bean="CreateCreditCardFormHandler.creditCard.CreditCardNumber" maxsize="20" size="20" type="text" value="4111111111111111"/>
<br>CreditCardType:
<dsp:select bean="CreateCreditCardFormHandler.creditCard.creditCardType" required="<%=true%>">
<dsp:option value="Visa"/>Visa
<dsp:option value="MasterCard"/>Master Card
<dsp:option value="American Express"/>American Express
</dsp:select>

<br>ExpirationMonth: <dsp:select bean="CreateCreditCardFormHandler.creditCard.ExpirationMonth">
<dsp:option value="1"/>January
<dsp:option value="2"/>February
<dsp:option value="3"/>March
<dsp:option value="4"/>April
<dsp:option value="5"/>May
<dsp:option value="6"/>June
<dsp:option value="7"/>July
<dsp:option value="8"/>August
<dsp:option value="9"/>September
<dsp:option value="10"/>October
<dsp:option value="11"/>November
<dsp:option value="12"/>December
</dsp:select>

<br>expirationYear:Year: <dsp:select bean="CreateCreditCardFormHandler.creditCard.expirationYear">
<dsp:option value="2016"/>2016
<dsp:option value="2017"/>2017
<dsp:option value="2018"/>2018
<dsp:option value="2019"/>2019
<dsp:option value="2020"/>2020
</dsp:select>


<br>FirstName:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.firstName" beanvalue="Profile.firstName" size="30" type="text"/>
<br>MiddleName:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.middleName" beanvalue="Profile.middleName" size="30" type="text"/>
<br>LastName:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.lastName" beanvalue="Profile.lastName" size="30" type="text"/>
<br>EmailAddress:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.email" beanvalue="Profile.email" size="30" type="text"/>
<br>PhoneNumber:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.phoneNumber" beanvalue="Profile.daytimeTelephoneNumber" size="30" type="text"/>
<br>Address:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.address1" beanvalue="Profile.defaultBillingAddress.address1" size="30" type="text"/>
<br>Address (line 2):<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.address2" beanvalue="Profile.defaultBillingAddress.address2" size="30" type="text"/>
<br>City:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.city" beanvalue="Profile.defaultBillingAddress.city" size="30" type="text"/>
<br>State:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.state" beanvalue="Profile.defaultBillingAddress.state" size="30" type="text"/>
<br>PostalCode:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.postalCode" beanvalue="Profile.defaultBillingAddress.postalCode" size="30" type="text"/>
<br>Country:<dsp:input bean="CreateCreditCardFormHandler.creditCard.billingAddress.country" beanvalue="Profile.defaultBillingAddress.country" size="30" type="text"/>
<br><dsp:input bean="CreateCreditCardFormHandler.copyToProfile" type="checkbox"/> Check to add card to profile
<br>

<dsp:input bean="CreateCreditCardFormHandler.newCreditCardSuccessURL" type="hidden" value="my_billing.jsp?init=false"/>
<dsp:input bean="CreateCreditCardFormHandler.newCreditCardErrorURL" type="hidden" value="credit_card.jsp"/>
<dsp:input bean="CreateCreditCardFormHandler.newCreditCard" type="submit" value="Enter Credit Card"/>

</dsp:form>

         </font>
       </td>
      </tr>
    </table>




</body>
</html>
</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/DynamusicB2B/j2ee-apps/dynamusicb2b-j2ee/dynamusicb2b.war/credit_card.jsp#9 $$Change: 514668 $--%>
