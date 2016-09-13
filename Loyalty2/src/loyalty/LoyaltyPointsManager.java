package loyalty;

import atg.nucleus.GenericService;
import atg.repository.MutableRepository;
import atg.repository.MutableRepositoryItem;
import atg.repository.Repository;
import atg.repository.RepositoryException;

public class LoyaltyPointsManager extends GenericService {
	
	private Repository profileRepository;
	private LoyaltySettings loyaltySettings;

	public boolean decUserAmount (LoyaltyPointsInfo lpInfo) {
		String userId = lpInfo.getUserId();
		double amount = lpInfo.getAmount();
		int points = lpInfo.getPoints();
		
		MutableRepository mutRepos = (MutableRepository) getProfileRepository();
		try {
			MutableRepositoryItem user = mutRepos.getItemForUpdate(userId, "user");
			int usersLoyaltyAmount = (Integer) user.getPropertyValue("loyaltyAmount");
			if (points == usersLoyaltyAmount && points >= amount) {
				int pointAmount = (int) Math.ceil(amount / getLoyaltySettings().getPointToDollar());
				int newAmount = points - pointAmount;
				user.setPropertyValue("loyaltyAmount", newAmount);
				mutRepos.updateItem(user);
				return true;
			} 
		} catch (RepositoryException e) {
			if (isLoggingError())
				logError("Exception occured trying to add loyaltyTransaction to user. ", e);
		}
		return false;
	}
	
	public Repository getProfileRepository() {
		return profileRepository;
	}

	public void setProfileRepository(Repository profileRepository) {
		this.profileRepository = profileRepository;
	}

	public LoyaltySettings getLoyaltySettings() {
		return loyaltySettings;
	}

	public void setLoyaltySettings(LoyaltySettings loyaltySettings) {
		this.loyaltySettings = loyaltySettings;
	}
	
	

}
