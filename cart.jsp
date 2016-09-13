<%@ taglib uri="dsp" prefix="dsp" %>
<%@ taglib uri="core" prefix="core" %>

<dsp:page>

<%--
This is the shopping cart. All items in the current order are displayed,
priced, and manipulated through this page.
--%>


<DECLAREPARAM NAME="giftlistId" CLASS="String" DESCRIPTION="The giftlist Id">
<DECLAREPARAM NAME="giftId" CLASS="String" DESCRIPTION="The giftitem Id">

<dsp:importbean bean="/atg/commerce/order/ShoppingCartModifier"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/Compare"/>
<dsp:importbean bean="/atg/commerce/gifts/IsGiftShippingGroup"/>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistLookupDroplet"/>
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>

<% atg.servlet.DynamoHttpServletRequest dRequest =
      atg.servlet.ServletUtil.getDynamoRequest(request); 
%>

<dsp:droplet name="RepriceOrderDroplet">
   <dsp:param name="pricingOp" value="ORDER_TOTAL"/>
</dsp:droplet>

<dsp:setvalue bean="Profile.currentLocation" value="shopping_cart"/>

<%-- 
Move any gift items to cart BEFORE repricing order object
--%>
<dsp:include page="move_gift_to_cart.jsp" flush="false"></dsp:include>

<%-- 
reprice the order before displaying any info from the Order object 
--%>

<dsp:setvalue bean="ShoppingCartModifier.repriceOrder" value="ORDER_SUBTOTAL"/>

<dsp:include page="../common/HeadBody.jsp" flush="false">
  <dsp:param name="pagetitle" value="Pioneer Cycling - View Shopping Cart"/>
</dsp:include>
                            
<dsp:include page="../common/StoreBrand.jsp" flush="false"></dsp:include>

<span class=storelittle> 
<!-- Display Navigation information (list of all parent -->
<!-- categories as links users can jump to)             -->
<dsp:include page="../catalog/common/breadcrumbs.jsp" flush="false">
  <dsp:param name="displaybreadcrumbs" value="true"/>
  <dsp:param name="no_new_crumb" value="true"/>
</dsp:include>     
</span>

<p>
<dsp:include page="../common/DisplayMediaSlot.jsp" flush="false">
  <dsp:param name="NumToDisplay" value="1"/>
</dsp:include>
<p>

<%-- 
Display any errors that have been generated up until now on the form.
--%>
<dsp:include page="../common/DisplayShoppingCartModifierErrors.jsp" flush="false"></dsp:include>

<p>
<span class=storebig>My Shopping Cart</span><br>
<p>

   <table cellspacing=0 cellpadding=0 border=0>
    <tr valign=top><td><table cellspacing=0 cellpadding=0 border=0>

    <!-- TABLE HEADERS: -->
    <tr align=left>
  
      <!-- QTY table header: -->
      <td class=box-top-viewmy>X</td>
      <td class=box-top-viewmy>Qty</td>
      <td class=box-top-viewmy>&nbsp;</td>
      <td clas=box-top-viewmy>&nbsp;&nbsp;</td>
    
      <!-- PRODUCT NAME table header: -->
      <td class=box-top-viewmy>Product Name</td>
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
      
      <!-- INVENTORY -->
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
 
      <!-- Price table header: -->
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
      <td class=box-top-viewmy>Price</td>
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
      <td class=box-top-viewmy>&nbsp;&nbsp;</td>
    </tr>

<dsp:form action="cart.jsp" method="post">



	<%-- URLs to go to on success/failure of various functions --%>

    <dsp:input bean="ShoppingCartModifier.setOrderByRelationshipIdSuccessURL" type="hidden" value="cart.jsp"/> 
	                                      
    <dsp:input bean="ShoppingCartModifier.setOrderByRelationshipIdErrorURL" type="hidden" value="cart.jsp"/>

    <dsp:input bean="ShoppingCartModifier.editItemSuccessURL" type="hidden" value="full/cart_edit.jsp"/>
	
    <dsp:input bean="ShoppingCartModifier.editItemErrorURL" type="hidden" value="basic/cart_edit.jsp"/>



  

    <%--
    Iterate through the cart's shipping groups and output 1 line item per commerce item.
    Output different headers for electronic shipping groups, hardgood groups, or gift groups.
    --%>

          
   <dsp:droplet name="ForEach">
     <dsp:param bean="ShoppingCartModifier.Order.ShippingGroups" name="array"/>
     <dsp:param name="elementName" value="ShippingGroup"/>
     <dsp:param name="indexName" value="shippingGroupIndex"/>
     <dsp:oparam name="output">
       <core:switch value='<%= dRequest.getParameter("ShippingGroup.shippingGroupClassType") %>'>

         <core:case value="electronicShippingGroup">
         
           <dsp:droplet name="ForEach">
             <dsp:param name="array" param="ShippingGroup.CommerceItemRelationships"/>
             <dsp:param name="elementName" value="CiRelationship"/>
             <dsp:param name="indexName" value="index"/>
             <dsp:oparam name="outputStart">
               <tr><td colspan=13>&nbsp;<Br>Electronic delivery to
               <dsp:valueof param="ShippingGroup.emailAddress">unknown email address</dsp:valueof>:
               <hr size=0></td></tr>
             </dsp:oparam>
             <dsp:oparam name="output">	
                 <dsp:setvalue param="itemName" value='<%= "item" + dRequest.getParameter("shippingGroupIndex") + ":" +dRequest.getParameter("index")%>'/> 
                 <%@ include file="CartLineItem.jspf" %>
             </dsp:oparam>
           </dsp:droplet>	
         </core:case>	
         
         <core:defaultCase>
    
           <dsp:droplet name="IsGiftShippingGroup">
             <dsp:param name="sg" param="ShippingGroup"/>
             <dsp:oparam name="false">
             <dsp:droplet name="ForEach">
               <dsp:param name="array" param="ShippingGroup.CommerceItemRelationships"/>
               <dsp:param name="elementName" value="CiRelationship"/>
               <dsp:param name="indexName" value="index"/>
               <dsp:oparam name="outputStart">
                 <tr><td colspan=13>&nbsp;<br>Shipping to you:<hr size=0></td></tr>
               </dsp:oparam>
               <dsp:oparam name="output">
                 <dsp:setvalue param="itemName" value='<%="item" + dRequest.getParameter("shippingGroupIndex") + ":" +dRequest.getParameter("index")%>'/>
                 <%@ include file="CartLineItem.jspf" %>
               </dsp:oparam>
             </dsp:droplet>	
           </dsp:oparam>
           <dsp:oparam name="true">
				
             <dsp:droplet name="ForEach">
               <dsp:param name="array" param="ShippingGroup.CommerceItemRelationships"/>
               <dsp:param name="elementName" value="CiRelationship"/>
               <dsp:param name="indexName" value="index"/>
               <dsp:oparam name="outputStart">
                 <tr><td colspan=13>&nbsp;<br>Gifts
                 <dsp:droplet name="GiftlistLookupDroplet">
                   <dsp:param name="id" param="giftlistId"/>
                   <dsp:param name="elementName" value="giftlist"/>
                   <dsp:oparam name="output">
                     for 
                     <dsp:valueof param="giftlist.owner.firstName"/>
                     <dsp:valueof param="giftlist.owner.lastName"/>
                   </dsp:oparam>
                 </dsp:droplet>:
                 <hr size=0></td></tr>
                 </dsp:oparam>
                 <dsp:oparam name="output">			
                    <dsp:setvalue param="itemName" value='<%="item" + dRequest.getParameter("shippingGroupIndex") + ":" +dRequest.getParameter("index")%>'/>
                    <%@ include file="CartLineItem.jspf" %>
                 </dsp:oparam>
               </dsp:droplet>	
				
             </dsp:oparam>
           </dsp:droplet>
			
       </core:defaultCase>
       </core:switch> 			
     </dsp:oparam>
   </dsp:droplet>




  <!-- Display a seperator line: -->
  <tr><td colspan=13><hr size=0></td></tr>


  <%-- Obtain two subtotals.  One that represents the subtotal after promotions and then
     the one from before promotions.  This allows the end user to view the two different ones.
  --%>
  
<dsp:getvalueof id="subtotal" bean="ShoppingCartModifier.order.priceInfo.rawSubtotal"> 
<dsp:getvalueof id="amount" bean="ShoppingCartModifier.order.priceInfo.amount"> 
<core:exclusiveIf>                   
  <core:ifEqual object1="<%=subtotal%>" 
                object2="<%=amount%>">
    <tr>
      <td colspan=9 align=right>Subtotal</td>
      <td></td>
      <td align=right>    
       <b><dsp:valueof converter="currency" bean="ShoppingCartModifier.order.priceInfo.amount"/></b>
      </td>
    </tr>
  </core:ifEqual>
  <core:defaultCase>
    <tr>
      <td colspan=9 align=right>Subtotal with order discount</td>
      <td></td>
      <td align=right>    
        <span class=strikeout>
          <dsp:valueof converter="currency" bean="ShoppingCartModifier.order.priceInfo.rawSubtotal"/>
        </span>
      </td>
      <td></td>
      <td align=right>    
        <b><dsp:valueof converter="currency" bean="ShoppingCartModifier.order.priceInfo.amount"/></b>
      </td>
    </tr>
  </core:defaultCase>            
</core:exclusiveIf>
</dsp:getvalueof>
</dsp:getvalueof>


</table>

<p>

<%-- URL to go to if user's session expires while he is filling out this form --%>
<dsp:input bean="ShoppingCartModifier.sessionExpirationURL" type="hidden" value="../common/SessionExpired.jsp"/>

<!-- EXPRESS CHECKOUT button: -->
<!------------------------------->

<!--  GoTo this URL if user pushes EXPRESS CHECKOUT button and
      there are no errors: -->                       
<dsp:input bean="ShoppingCartModifier.expressCheckoutSuccessURL" type="hidden" value="full/co_confirm.jsp"/> 

<!-- RECALCULATE Order button: -->
<!------------------------------->
<dsp:input bean="ShoppingCartModifier.setOrderByRelationshipId" type="submit" value="Recalculate"/> &nbsp; &nbsp;

<!--  GoTo this URL if user pushes RECALCULATE button and
      there are no errors: -->                       
<dsp:input bean="ShoppingCartModifier.setOrderByRelationshipIdSuccessURL" type="hidden" value="cart.jsp"/> <!-- stay here -->
       
<!--  GoTo this URL if user pushes RECALCULATE button and
      there are errors: -->                       
<dsp:input bean="ShoppingCartModifier.setOrderByRelationshipIdErrorURL" type="hidden" value="cart.jsp"/> <!-- stay here -->

<!-------------------------------------------------------------------->    
<!-- COMMENT TO USE FULL CHECKOUT                                   -->

<!-- CHECKOUT Order button: -->
<!---------------------------->

<!-- Begin Comment
<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelId" type="submit" value="   Checkout"/>

<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelIdSuccessURL" type="hidden" value="basic/order_info.jsp"/>
       
<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelIdErrorURL" type="hidden" value="cart.jsp"/> 
-->

<dsp:getvalueof id="allowExpressCheckout" idtype="Boolean" bean="Profile.expressCheckout">
<core:if value="<%=allowExpressCheckout.booleanValue()%>">
  <dsp:input bean="ShoppingCartModifier.expressCheckout" type="submit" value=" Express  Checkout"/>
</core:if>
</dsp:getvalueof>


<!-------------------------------------------------------------------->
<!-- UNCOMMENT TO USE FULL CHECKOUT                                 -->

<!-- CHECKOUT Order button: -->
<!---------------------------->

<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelId" type="submit" value="   Checkout"/>

<%--
  Use this snippet if you want regular http checkout:
<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelIdSuccessURL" type="hidden" value="full/order_info.jsp"/>

--%>


<%--  Use this snippet if you want to use SSL checkout: 
--%>
<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
  <dsp:param name="inUrl" value="full/order_info.jsp"/>
  <dsp:oparam name="output">
    <dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelIdSuccessURL" paramvalue="secureUrl" type="hidden"/>
  </dsp:oparam>
</dsp:droplet>
       
<dsp:input bean="ShoppingCartModifier.moveToPurchaseInfoByRelIdErrorURL" type="hidden" value="cart.jsp"/> 


</dsp:form>



<p>
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>


</td>
</tr></table>


<p>
&nbsp;<br>

<dsp:include page="../common/DisplayActivePromotions.jsp" flush="false"></dsp:include>

<p>

<dsp:include page="../user/CouponClaim.jsp" flush="false"></dsp:include>

<p>

<dsp:include page="../common/StoreFooter.jsp" flush="false"></dsp:include> 
<dsp:include page="../common/Copyright.jsp" flush="false"></dsp:include>

</BODY>
</HTML>
</dsp:page>
<%-- @version $Id: //edu/ILT-Courses/main/Commerce/StudentFiles/Commerce/setup/cart.jsp#3 $$Change: 514668 $--%>
