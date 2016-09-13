package loyalty;

import java.util.Date;

import atg.payment.*;

public class LoyaltyPointsStatus extends PaymentStatusImpl {
	private Date authorizationExpiration;
	
	public LoyaltyPointsStatus() {
		super();
	}

	public LoyaltyPointsStatus(java.lang.String pTransactionId, double pAmount, boolean pTransactionSuccess, java.lang.String pErrorMessage, java.util.Date pTransactionTimestamp, java.util.Date pAuthorizationExpiration)  {
		setTransactionId(pTransactionId);
		setAmount(pAmount);
		setTransactionSuccess(pTransactionSuccess);
		setErrorMessage(pErrorMessage);
		setTransactionTimestamp(pTransactionTimestamp);
		authorizationExpiration = pAuthorizationExpiration;		
	}
	
	

	public Date getAuthorizationExpiration() {
		return authorizationExpiration;
	}

	public void setAuthorizationExpiration(Date authorizationExpiration) {
		this.authorizationExpiration = authorizationExpiration;
	}
}