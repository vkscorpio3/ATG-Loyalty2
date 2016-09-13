<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet"/>
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/dynamo/droplet/BeanProperty"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<!-- ATG Training -->
<!-- Creating Commerce Applications -->
<!-- page to split payment -->
<!-- Last modified: 20 Apr 06 by KL -->

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


<%/* Check for errors */%>
<dsp:droplet name="Switch">
  <dsp:param bean="PaymentGroupFormHandler.formError" name="value"/>
  <dsp:oparam name="true">
    <font color=cc0000><STRONG><UL>
      <dsp:droplet name="ErrorMessageForEach">
        <dsp:param bean="PaymentGroupFormHandler.formExceptions" name="exceptions"/>
        <dsp:oparam name="output">
        <LI> <dsp:valueof param="message"/>
        </dsp:oparam>
      </dsp:droplet>
    </UL></STRONG></font>
  </dsp:oparam>
</dsp:droplet>

<dsp:droplet name="PaymentGroupDroplet">

	<dsp:param name="clearPaymentGroups" param="init"/>
	<dsp:param name="initPaymentGroups" param="init"/>
	<dsp:param name="paymentGroupTypes" value="creditCard,loyaltyPoints"/>
	<dsp:param name="clearPaymentInfos" value="true"/>
	<dsp:param name="initOrderPayment" value="true"/>

  <dsp:oparam name="output">

    <!-- Set the listId property of the PaymentGroupFormHandler. -->
    <dsp:setvalue bean="PaymentGroupFormHandler.listId" paramvalue="order.id"/>

    <dsp:include page="payment_table_hdr.jsp" flush="true"></dsp:include>

                  <dsp:droplet name="ForEach">

                  <!-- Iterate over the currentList of OrderPaymentInfo objects -->
                    <dsp:param name="array" bean="PaymentGroupFormHandler.currentList" />
                    <dsp:oparam name="output">                      
                      <dsp:form formid="split" action="split_payment.jsp?init=true" method="post">

                      <tr valign=top>
                        <td><dsp:valueof converter="currency" param="element.amount"/></td>
                        <td>&nbsp;</td>


                        <td>$<!-- Input the split amount. -->
                           <dsp:input bean="PaymentGroupFormHandler.currentList[param:index].splitAmount" size="6" type="text"/>
                        </td>

                        <td>&nbsp;</td>
                        <td>
                          
                           <dsp:getvalueof id="payMethod" idtype="String" param="element.paymentMethod" >
                          <!-- Select the payment method. -->
			<dsp:select bean="PaymentGroupFormHandler.currentList[param:index].splitPaymentMethod">
                            <%@ include file="payment_select_list.jspf" %>
                          </dsp:select>

                          </dsp:getvalueof>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>
                          <!-- Preserve the listId. -->
                          <dsp:input bean="PaymentGroupFormHandler.listId" paramvalue="order.id" priority="<%=(int)9%>" type="hidden"/>

                          <!-- Set the split payment success URL. -->
                          <dsp:input bean="PaymentGroupFormHandler.splitPaymentInfosSuccessURL" type="hidden" value="split_payment.jsp?init=false"/>
                          <!-- Submit the form to split payment infos. -->
                          <dsp:input bean="PaymentGroupFormHandler.splitPaymentInfos" type="submit" value=" Save "/>

                        </td>
                      </tr>
                      </dsp:form>
                    </dsp:oparam>
                  </dsp:droplet>
                 <dsp:include page="payment_tbl_footer.jsp" flush="true"></dsp:include>
<br>
            <dsp:form formid="save" action="split_payment.jsp?init=false" method="post">

             <!-- Set the apply payment groups success URL. --> 
            <dsp:input bean="PaymentGroupFormHandler.applyPaymentGroupsSuccessURL" type="hidden" value="orderconfirm.jsp"/>
            <!-- Submit the form to apply payment groups to order. -->
            <dsp:input bean="PaymentGroupFormHandler.applyPaymentGroups" type="submit" value="Continue"/>

            </dsp:form>
    </div> </td></tr></table>
  </dsp:oparam>
</dsp:droplet>
</BODY>
</HTML>

</dsp:page>
