package loyalty;

import atg.nucleus.GenericService;

public class LoyaltyPointsProcessorImpl extends GenericService implements LoyaltyPointsProcessor {
	private LoyaltyPointsManager loyaltyPointsManager;

	public LoyaltyPointsStatus authorize(LoyaltyPointsInfo pLoyaltyPointsInfo) {

		if (isLoggingDebug())
			logDebug("Authorizing loyalty points payment group " + pLoyaltyPointsInfo.getUserId() + " for "
					+ pLoyaltyPointsInfo.getPoints());
		return new LoyaltyPointsStatus(Long.toString(System.currentTimeMillis()), pLoyaltyPointsInfo.getAmount(), true,
				"", new java.util.Date(), new java.util.Date(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
	}

	public LoyaltyPointsStatus debit(LoyaltyPointsInfo pLoyaltyPointsInfo, LoyaltyPointsStatus pStatus) {
		if (isLoggingDebug())
			logDebug("Debiting loyalty points payment group " + pLoyaltyPointsInfo.getUserId() + " for "
					+ pLoyaltyPointsInfo.getPoints());
		
		
		if (!loyaltyPointsManager.decUserAmount(pLoyaltyPointsInfo)) {
			return new LoyaltyPointsStatus(Long.toString(System.currentTimeMillis()), pLoyaltyPointsInfo.getAmount(),
					false, "Could not decreace users loyaltyAmount", new java.util.Date(),
					new java.util.Date(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
		}
		
		
		return new LoyaltyPointsStatus(Long.toString(System.currentTimeMillis()), pLoyaltyPointsInfo.getAmount(), true,
				"", new java.util.Date(), new java.util.Date(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
	}

	public LoyaltyPointsStatus credit(LoyaltyPointsInfo pLoyaltyPointsInfo, LoyaltyPointsStatus pStatus) {

		if (isLoggingDebug())
			logDebug("Crediting loyalty points payment group " + pLoyaltyPointsInfo.getUserId() + " for "
					+ pLoyaltyPointsInfo.getPoints());

		return new LoyaltyPointsStatus(Long.toString(System.currentTimeMillis()), pLoyaltyPointsInfo.getAmount(), true,
				"", new java.util.Date(), new java.util.Date(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
	}

	public LoyaltyPointsStatus credit(LoyaltyPointsInfo pLoyaltyPointsInfo) {
		
		if (isLoggingDebug())
			logDebug("Crediting loyalty points payment group " + pLoyaltyPointsInfo.getUserId() + " for "
					+ pLoyaltyPointsInfo.getPoints());
		return new LoyaltyPointsStatus(Long.toString(System.currentTimeMillis()), pLoyaltyPointsInfo.getAmount(), true,
				"", new java.util.Date(), new java.util.Date(System.currentTimeMillis() + (24 * 60 * 60 * 1000)));
	}

	public LoyaltyPointsManager getLoyaltyPointsManager() {
		return loyaltyPointsManager;
	}

	public void setLoyaltyPointsManager(LoyaltyPointsManager loyaltyPointsManager) {
		this.loyaltyPointsManager = loyaltyPointsManager;
	}

}