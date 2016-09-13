package loyalty;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import atg.droplet.DropletException;
import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.repository.servlet.RepositoryFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class LoyaltyFormHandler extends RepositoryFormHandler {
	private LoyaltyManager loyaltyManager;
	private TransactionManager transactionManager;

	@Override
	public boolean handleCreate(DynamoHttpServletRequest request, DynamoHttpServletResponse response)
			throws ServletException, IOException {

		if (isLoggingDebug())
	  		logDebug("Validating amount input field of the form");
		Integer amount = (Integer) getValueProperty("amount");
		if (amount == null) {
			addFormException(new DropletException("Wrong format of input amount."));
			response.sendLocalRedirect(getCreateErrorURL(), request);
			return false;
		}
		String userId = (String) getValueProperty("profileId");
		try {
			TransactionDemarcation td = new TransactionDemarcation();
			td.begin(transactionManager, td.REQUIRED);
			try {
				if (isLoggingDebug())
			  		logDebug("Creating 'loyaltyTransaction' item");
				boolean flag = super.handleCreate(request, response);
				
				if (isLoggingDebug())
			  		logDebug("Invoking loyaltyManager.addTransactionToUser() method");
				loyaltyManager.addTransactionToUser(getRepositoryId(), userId);
				
				return flag;				
			} catch (Exception e) {
				logErrorAddException ("Cannot add loyaltyTransaction to user's loyaltyTransactions", e);
				try {
					getTransactionManager().setRollbackOnly();
				} catch (SystemException se) {
					logErrorAddException("Unable to set rollback for transaction", se);
				}
				response.sendLocalRedirect(getCreateErrorURL(), request);
				return false;				
			} finally {
				td.end();
			}
		} catch (TransactionDemarcationException e) {
			logErrorAddException("Creating TransactionDemarcation failed, no loyaltyTransaction was added to user.", e);
			response.sendLocalRedirect(getCreateErrorURL(), request);
			return false;
		}
	}
	
	private void logErrorAddException (String message, Exception e) {
		if (isLoggingError())
			logError(message, e);
		addFormException(new DropletException(message, e));
	}

	
	public LoyaltyManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(LoyaltyManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}

	public TransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(TransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	
}
