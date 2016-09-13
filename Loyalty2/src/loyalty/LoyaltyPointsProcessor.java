package loyalty;


public interface LoyaltyPointsProcessor {
	
	LoyaltyPointsStatus authorize(LoyaltyPointsInfo pLoyaltyPointsInfo);
	
	LoyaltyPointsStatus debit(LoyaltyPointsInfo pLoyaltyPointsInfo, LoyaltyPointsStatus pStatus);
	
	LoyaltyPointsStatus credit(LoyaltyPointsInfo pLoyaltyPointsInfo, LoyaltyPointsStatus pStatus);
	
	LoyaltyPointsStatus credit(LoyaltyPointsInfo pLoyaltyPointsInfo);
}