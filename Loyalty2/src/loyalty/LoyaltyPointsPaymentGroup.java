package loyalty;

import atg.commerce.order.*;

public class LoyaltyPointsPaymentGroup extends PaymentGroupImpl {

	public String getUserId() {
		return (String) getPropertyValue("userId");
	}

	public void setUserId(String pUserId) {
		setPropertyValue("userId", pUserId);
	}

	public int getPoints() {
		return ((Integer) getPropertyValue("loyaltyPoints")).intValue();
	}

	public void setPoints(int points) {
		setPropertyValue("loyaltyPoints", new Integer(points));
	}
}