<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>

<%
/*-------------------------------------------------
Display any errors that have been generated by the
Approval FormHandler up until now.
-------------------------------------------------------*/
%>

<dsp:importbean bean="/atg/commerce/approval/ApprovalFormHandler"/>

<dsp:droplet name="/atg/dynamo/droplet/Switch">
  <dsp:param bean="ApprovalFormHandler.formError" name="value"/>
  <dsp:oparam name="true">
    <font color=cc0000><STRONG>There was a problem with the approval process.
    <UL>
    <dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
      <dsp:param bean="ApprovalFormHandler.formExceptions" name="exceptions"/>
      <dsp:oparam name="output">
        <LI><dsp:valueof param="message"/>
      </dsp:oparam>
    </dsp:droplet>
    </UL></STRONG></font>
  </dsp:oparam>
</dsp:droplet>

</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/DynamusicB2B/j2ee-apps/dynamusicb2b-j2ee/dynamusicb2b.war/ApprovalFormHandlerErrorMessages.jsp#5 $$Change: 514668 $--%>
