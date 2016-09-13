<%@ taglib uri="/dspTaglib" prefix="dsp"%>
<dsp:page>
	<dsp:importbean bean="/loyalty/LoyaltyFormHandler" />

	<HTML>
<TITLE>Loyalty Administrator</TITLE>
<HEAD>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<script src="js/dropdownScript.js"></script>
</HEAD>
<BODY>

	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Loyalty Admin" />
	</dsp:include>
	<table width="700" cellpadding="8">
		<tr>
			<!-- Sidebar -->
			<td width="100" bgcolor="ghostwhite" valign="top"><dsp:include
					page="common/sidebar.jsp"></dsp:include></td>
			<!-- Page Body -->

			<td valign="top"><font face="Verdana,Geneva,Arial" size="-1">

					<!-- *** Start page content *** --> 
					<dsp:droplet name="/atg/dynamo/droplet/HasEffectivePrincipal">
						<dsp:param name="type" value="role" />
						<dsp:param name="id" value="loyaltyAdministrator" />
						<dsp:oparam name="output">

							<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
								<dsp:oparam name="output">
									<b><dsp:valueof param="message" /></b>
									<br>
								</dsp:oparam>
							</dsp:droplet>
							<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
								<dsp:param name="repository"
									value="/atg/userprofiling/ProfileAdapterRepository" />
								<dsp:param name="itemDescriptor" value="user" />
								<dsp:param name="queryRQL" bean='/loyalty/Queries.allQuery' /> 					
								
								<dsp:oparam name="output">
									<div class="dropdown">
										<button
											onclick="showDropdown(<dsp:valueof param='element.id'/>)"
											class="dropbtn">
											<dsp:valueof param="element.firstName" />
											<dsp:valueof param="element.lastName" />:
											<dsp:valueof param="element.loyaltyAmount"/> points 
										</button>
										<div id="<dsp:valueof param='element.id'/>"
											class="dropdown-content">
											<dsp:form action="loyaltyAdmin.jsp" method="post">

												<p>Enter points:</p>
												<br>
												<dsp:input bean="LoyaltyFormHandler.value.amount"
													name="amount" required="true" />
												<p>Enter description:</p>
												<br>
												<dsp:textarea bean="LoyaltyFormHandler.value.description"
													name="description" maxlength="1000" cols="40" rows="5"
													wrap="SOFT" />
												<br>

												<dsp:input type="hidden"
													bean="LoyaltyFormHandler.value.profileId"
													paramvalue="element.id" />

												<dsp:input type="submit" value="Add"
													bean="LoyaltyFormHandler.create" />
											</dsp:form>
										</div>
									</div>
								</dsp:oparam>
								<dsp:oparam name="empty">
									<p>No artists currently available, sorry.
								</dsp:oparam>
							</dsp:droplet>
						</dsp:oparam>
						<dsp:oparam name="default">
                    		Sorry, you do not have access to this page.
                    	</dsp:oparam>
						<dsp:oparam name="unknown">
                    		Please log in.
                    	</dsp:oparam>

					</dsp:droplet> <!-- *** End content *** -->
			</font></td>
	</table>
</BODY>
	</HTML>
</dsp:page>

