package loyalty;

import java.util.Collection;

import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.nucleus.GenericService;
import atg.repository.*;
import atg.userdirectory.User;
import atg.userdirectory.UserDirectory;

public class LoyaltyManager extends GenericService {

	private Repository loyaltyRepository;
	private Repository profileRepository;

	public LoyaltyManager() {
	}
	
	public void addTransactionToUser(String loyaltyTransactionId, String userId) throws RepositoryException {
		if (isLoggingDebug()) {
			logDebug("Adding loyalty transaction to user with id: " + userId);		
		}
		MutableRepository mutRepos = (MutableRepository) getProfileRepository();
		try {
			MutableRepositoryItem user = mutRepos.getItemForUpdate(userId, "user");
			RepositoryItem loyaltyTransaction = loyaltyRepository.getItem(loyaltyTransactionId, "loyaltyTransaction");
			Collection loyaltyTransactionList = (Collection) user.getPropertyValue("loyaltyTransactions");
			loyaltyTransactionList.add(loyaltyTransaction);
			mutRepos.updateItem(user);

			// delete element from cache to make sure loyaltyAmount value will be updated
			if (isLoggingDebug()) {
				logDebug("Invalidating item cache");		
			}
			RepositoryImpl rep = (RepositoryImpl) getProfileRepository();
			ItemDescriptorImpl d = (ItemDescriptorImpl) rep.getItemDescriptor("user");
			d.invalidateItemCache();
		} catch (RepositoryException e) {
			if (isLoggingError())
				logError("Exception occured trying to add loyaltyTransaction to user. ", e);
			throw e;
		}
	}

	public Repository getLoyaltyRepository() {
		return loyaltyRepository;
	}

	public void setLoyaltyRepository(Repository loyaltyRepository) {
		this.loyaltyRepository = loyaltyRepository;
	}

	public Repository getProfileRepository() {
		return profileRepository;
	}

	public void setProfileRepository(Repository profileRepository) {
		this.profileRepository = profileRepository;
	}

}