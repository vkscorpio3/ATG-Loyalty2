<%@ taglib uri="dsp" prefix="dsp" %>
<dsp:page>

<dsp:importbean bean="/atg/commerce/order/scheduled/ScheduledOrderFormHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/IsNull"/>
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/commerce/pricing/PriceItem"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<DECLAREPARAM NAME="scheduledOrderId" CLASS="java.lang.String" DESCRIPTION="The id of the Scheduled order to manipulate">
<DECLAREPARAM NAME="createNew" CLASS="java.lang.String" DESCRIPTION="Determines whether create new scheduled order or not">

<dsp:include page="../common/HeadBody.jsp" flush="true"><dsp:param name="pagetitle" value=" Scheduled Orders"/></dsp:include>

<table border=0 cellpadding=0 cellspacing=0 width=800>
  <tr>
  </tr>
  <!--breadcrumbs-->
      <tr bgcolor="#DBDBDB" > 
        <td colspan=2 height=18> &nbsp; <span class=small>
        <dsp:a href="my_account.jsp">My Account</dsp:a> &gt;
        <dsp:a href="scheduled_orders.jsp">Scheduled Orders</dsp:a> &gt;
        <dsp:valueof bean="ScheduledOrderFormHandler.value.name"/></td>
      </tr>

  <tr valign=top> 
    <td width=55><img src="../images/d.gif" hspace=27></td>

    <!-- main content area -->
    <td valign="top" width=745>
      <table border=0 cellpadding=4 width=80%>
        <tr><td><img src="../images/d.gif"></td></tr>
        <tr valign=top>
          <td colspan=3><span class=big>My Account</span></td>
        </tr>
        <tr><td><img src="../images/d.gif"></td></tr>
        <!--error messages-->
    
        <tr valign=top>
        </tr>
        <tr>
            <td><table width=100% cellpadding=3 cellspacing=0 border=0>
              <tr><td class=box-top>&nbsp;Scheduled Order</td></tr></table>
        
              <dsp:form action="scheduled_order_preview.jsp" method="post"> 
              <table border=0 cellpadding=4>
                <tr valign=bottom>
                  <td align=right><span class=smallb>Name</span></td>
                  <td><dsp:valueof bean="ScheduledOrderFormHandler.value.name"/></td>
                </tr>
                <tr valign=bottom>
                  <td align=right><span class=smallb>Schedule</span></td>
                  <td width=75%>
                    <dsp:valueof bean="ScheduledOrderFormHandler.complexScheduledOrderMap.calendarSchedule.userInputFields.scheduleString"/></td>
                </tr>
                <tr valign=top>
                  <td align=right><span class=smallb>Beginning date</span></td>
                        <td><dsp:valueof bean="ScheduledOrderFormHandler.value.startDate" date="MMM d,yyyy h:mm a"/></td>
                </tr>
                <tr valign=top>
                  <td align=right><span class=smallb>End date</span></td>
                          <td><dsp:valueof bean="ScheduledOrderFormHandler.value.endDate" date="MMM d,yyyy h:mm a"/></td>
                </tr>
                <tr>
                  <td></td>
                  <td>
                  </td>
                </tr>
                        
        <tr valign=top>
          <td></td>
          <td>
            <p>
            <dsp:droplet name="IsNull">
              <dsp:param name="value" bean="ScheduledOrderFormHandler.repositoryId"/>
              <dsp:oparam name="true">
                <dsp:input bean="ScheduledOrderFormHandler.createErrorURL" type="hidden" value="scheduled_order_new.jsp"/>
                <dsp:input bean="ScheduledOrderFormHandler.createSuccessURL" type="hidden" value="scheduled_orders.jsp"/>
                <dsp:input bean="ScheduledOrderFormHandler.create" type="submit" value="Create scheduled order"/>
              </dsp:oparam>
              <dsp:oparam name="false">
                <dsp:input bean="ScheduledOrderFormHandler.deleteSuccessURL" type="hidden" value="scheduled_orders.jsp"/>
                <dsp:input bean="ScheduledOrderFormHandler.deleteErrorURL" type="hidden" value="scheduled_order_preview.jsp"/>
                <dsp:input bean="ScheduledOrderFormHandler.delete" type="submit" value="Delete scheduled order"/><p>
                <span class=smallb><dsp:a href="scheduled_orders.jsp">Return to scheduled orders</dsp:a></span>
              </dsp:oparam>
            </dsp:droplet>
        </tr>
    </table>
    </dsp:form>
    
  </td>
</tr>
<tr>
  <td></td>
  <td><p><br></td>
</tr>

<!-- vertical space -->
<tr><td><img src="../images/d.gif" vspace=0></td></tr>

</table>
<%-- </dsp:form> --%>
</td>
</tr>

</table>
</div>
</body>
</html>
</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/scheduled_order_preview.jsp#5 $$Change: 514668 $--%>
