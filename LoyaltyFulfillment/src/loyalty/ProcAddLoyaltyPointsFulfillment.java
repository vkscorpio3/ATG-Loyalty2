package loyalty;

import atg.service.pipeline.*;
import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.nucleus.GenericService;
import atg.repository.MutableRepository;
import atg.repository.MutableRepositoryItem;
import atg.repository.Repository;
import atg.commerce.fulfillment.*;
import atg.commerce.order.Order;
import atg.commerce.order.PaymentGroup;
import atg.commerce.order.CreditCard;
import atg.commerce.order.InvalidParameterException;

import java.util.*;
import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

public class ProcAddLoyaltyPointsFulfillment extends GenericService implements PipelineProcessor {

	private String itemDescriptorName;
	private Repository repository;
	private AddLoyaltyToUserManager loyaltyManager;
	private TransactionManager transactionManager;
	private LoyaltySettings loyaltySettings;

	private final int SUCCESS = 111;
	private final int ERROR = 112;

	public int[] getRetCodes() {
		int[] ret = { SUCCESS, ERROR };
		return ret;
	}

	public int runProcess(Object pParam, PipelineResult pResult) throws Exception {
		HashMap map = (HashMap) pParam;
		Order pOrder = (Order) map.get(PipelineConstants.ORDER);
		OrderFulfiller of = (OrderFulfiller) map.get(PipelineConstants.ORDERFULFILLER);

		if (pOrder == null)
			throw new InvalidParameterException("InvalidOrderParameter");
		if (of == null)
			throw new InvalidParameterException("InvalidOrderFulfillerParameter");

		try {
			TransactionDemarcation td = new TransactionDemarcation();
			td.begin(transactionManager, td.REQUIRED);
			try {

				List<PaymentGroup> paymentGroups = pOrder.getPaymentGroups();
				for (PaymentGroup pg : paymentGroups) {
					if (pg instanceof CreditCard) {
						CreditCard cc = (CreditCard) pg;
						double amount = cc.getAmount();
						int pointAmount = (int) Math.floor(amount * loyaltySettings.getPointsPerDollarForPurchase()); 
						
						String profileId = pOrder.getProfileId();

						MutableRepository mutRepos = (MutableRepository) getRepository();
						MutableRepositoryItem loyaltyTransaction = mutRepos.createItem(itemDescriptorName);
						String repoId = loyaltyTransaction.getRepositoryId();
						loyaltyTransaction.setPropertyValue("amount", pointAmount);
						loyaltyTransaction.setPropertyValue("profileId", profileId);
						loyaltyTransaction.setPropertyValue("id", repoId);

						mutRepos.addItem(loyaltyTransaction);

						loyaltyManager.addTransactionToUser(repoId, profileId);
					}
				}
				return SUCCESS;
			} catch (Exception e) {
				logError("Cannot add loyaltyTransaction to user's loyaltyTransactions", e);
				try {
					getTransactionManager().setRollbackOnly();
				} catch (SystemException se) {
					logError("Unable to set rollback for transaction", se);
				}
			} finally {
				td.end();
			}
		} catch (TransactionDemarcationException e) {
			logError("Creating TransactionDemarcation failed, no loyaltyTransaction was added to user.", e);
		}

		return ERROR;

	}

	public String getItemDescriptorName() {
		return itemDescriptorName;
	}

	public void setItemDescriptorName(String itemDescriptorName) {
		this.itemDescriptorName = itemDescriptorName;
	}

	public Repository getRepository() {
		return repository;
	}

	public void setRepository(Repository repository) {
		this.repository = repository;
	}

	public AddLoyaltyToUserManager getLoyaltyManager() {
		return loyaltyManager;
	}

	public void setLoyaltyManager(AddLoyaltyToUserManager loyaltyManager) {
		this.loyaltyManager = loyaltyManager;
	}

	public TransactionManager getTransactionManager() {
		return transactionManager;
	}

	public void setTransactionManager(TransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	public LoyaltySettings getLoyaltySettings() {
		return loyaltySettings;
	}

	public void setLoyaltySettings(LoyaltySettings loyaltySettings) {
		this.loyaltySettings = loyaltySettings;
	}
	
	
}
