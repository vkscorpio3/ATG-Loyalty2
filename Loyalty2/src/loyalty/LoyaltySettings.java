package loyalty;

public class LoyaltySettings {
	
	private int pointsPerDollarForPurchase;
	private double maxPartOfOrderForLoyalty;
	private double pointToDollar;
	
	public int getPointsPerDollarForPurchase() {
		return pointsPerDollarForPurchase;
	}
	public void setPointsPerDollarForPurchase(int pointsPerDollarForPurchase) {
		this.pointsPerDollarForPurchase = pointsPerDollarForPurchase;
	}
	public double getMaxPartOfOrderForLoyalty() {
		return maxPartOfOrderForLoyalty;
	}
	public void setMaxPartOfOrderForLoyalty(double maxPartOfOrderForLoyalty) {
		this.maxPartOfOrderForLoyalty = maxPartOfOrderForLoyalty;
	}
	public double getPointToDollar() {
		return pointToDollar;
	}
	public void setPointToDollar(double pointToDollar) {
		this.pointToDollar = pointToDollar;
	}
	
}
