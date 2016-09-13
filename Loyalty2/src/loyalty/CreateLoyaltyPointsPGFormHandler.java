package loyalty;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.transaction.Transaction;

import atg.commerce.CommerceException;
import atg.commerce.order.purchase.CreatePaymentGroupFormHandler;
import atg.commerce.order.purchase.PaymentGroupMapContainer;
import atg.commerce.order.purchase.PurchaseProcessFormHandler;
import atg.commerce.profile.CommercePropertyManager;
import atg.droplet.DropletFormException;
import atg.repository.MutableRepository;
import atg.repository.MutableRepositoryItem;
import atg.repository.RepositoryException;
import atg.repository.RepositoryItem;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class CreateLoyaltyPointsPGFormHandler extends PurchaseProcessFormHandler
		implements CreatePaymentGroupFormHandler {

	PaymentGroupMapContainer container;
	String loyaltyPointsPGName;
	String loyaltyPointsPGSuccessURL;
	String loyaltyPointsPGErrorURL;
	LoyaltyPointsPaymentGroup loyaltyPointsPG = null;
	String loyaltyPointsPGType;

	public PaymentGroupMapContainer getContainer() {
		return container;
	}

	public void setContainer(PaymentGroupMapContainer container) {
		this.container = container;
	}

	public String getLoyaltyPointsPGName() {
		return loyaltyPointsPGName;
	}

	public void setLoyaltyPointsPGName(String loyaltyPointsPGName) {
		this.loyaltyPointsPGName = loyaltyPointsPGName;
	}

	public String getLoyaltyPointsPGSuccessURL() {
		return loyaltyPointsPGSuccessURL;
	}

	public void setLoyaltyPointsPGSuccessURL(String loyaltyPointsPGSuccessURL) {
		this.loyaltyPointsPGSuccessURL = loyaltyPointsPGSuccessURL;
	}

	public String getLoyaltyPointsPGErrorURL() {
		return loyaltyPointsPGErrorURL;
	}

	public void setLoyaltyPointsPGErrorURL(String loyaltyPointsPGErrorURL) {
		this.loyaltyPointsPGErrorURL = loyaltyPointsPGErrorURL;
	}

	public String getLoyaltyPointsPGType() {
		return loyaltyPointsPGType;
	}

	public void setLoyaltyPointsPGType(String loyalyPointsPGType) {
		this.loyaltyPointsPGType = loyalyPointsPGType;
	}

	public LoyaltyPointsPaymentGroup getLoyaltyPointsPG() {
		if (loyaltyPointsPG == null) {
			try {
				loyaltyPointsPG = (LoyaltyPointsPaymentGroup) getPaymentGroupManager()
						.createPaymentGroup(getLoyaltyPointsPGType());				
			} catch (CommerceException exc) {
				if (isLoggingError())
					logError(exc);
			}
		}
		return loyaltyPointsPG;
	}

	public void setLoyaltyPointsPG(LoyaltyPointsPaymentGroup loyaltyPointsPG) {
		this.loyaltyPointsPG = loyaltyPointsPG;
	}

	public boolean handleCreateLoyaltyPointsPG(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException, IOException {
		Transaction tr = null;
		try {
			tr = ensureTransaction();

			if (!checkFormRedirect(null, getLoyaltyPointsPGErrorURL(), pRequest, pResponse))
				return false;

			preCreateLoyaltyPointsPaymentGroup(pRequest, pResponse);

			if (!checkFormRedirect(null, getLoyaltyPointsPGErrorURL(), pRequest, pResponse))
				return false;

			createLoyaltyPointsPaymentGroup(pRequest, pResponse);

			if (!checkFormRedirect(null, getLoyaltyPointsPGErrorURL(), pRequest, pResponse))
				return false;
			postCreateLoyaltyPointsPaymentGroup(pRequest, pResponse);

			return checkFormRedirect(getLoyaltyPointsPGSuccessURL(), getLoyaltyPointsPGErrorURL(), pRequest, pResponse);
		} finally {
			commitTransaction(tr);
		}
	}

	public void preCreateLoyaltyPointsPaymentGroup(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException, IOException {
	}

	public void postCreateLoyaltyPointsPaymentGroup(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) throws ServletException, IOException {
	}

	public void createLoyaltyPointsPaymentGroup(DynamoHttpServletRequest pRequest,
			DynamoHttpServletResponse pResponse) {
		
		copyConfiguration();
		container.addPaymentGroup(getLoyaltyPointsPGName(), getLoyaltyPointsPG());
	}

	protected void copyConfiguration() {
		super.copyConfiguration();
		if (getConfiguration() != null) {
			if (getContainer() == null) {
				setContainer(getConfiguration().getPaymentGroupMapContainer());
			}
		}
	}

	

	
}
