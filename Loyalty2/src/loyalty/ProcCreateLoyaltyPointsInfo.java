package loyalty;

import atg.nucleus.GenericService;
import atg.service.pipeline.PipelineProcessor;
import atg.service.pipeline.PipelineResult;
import atg.commerce.order.*;

import atg.commerce.payment.*;

public class ProcCreateLoyaltyPointsInfo extends GenericService implements PipelineProcessor{
	
	public static final int SUCCESS = 111;

	String loyaltyPointsInfoClass = "loyalty.LoyaltyPointsInfo";


	public String getLoyaltyPointsInfoClass() {
		return loyaltyPointsInfoClass;
	}

	public void setLoyaltyPointsInfoClass(String loyaltyPointsInfoClass) {
		this.loyaltyPointsInfoClass = loyaltyPointsInfoClass;
	}

	protected void addDataToLoyaltyPointsInfo(Order order, LoyaltyPointsPaymentGroup paymentGroup, 
	double amount, PaymentManagerPipelineArgs params, LoyaltyPointsInfo loyaltyPointsInfo){
		loyaltyPointsInfo.setUserId(paymentGroup.getUserId());
		loyaltyPointsInfo.setPoints(paymentGroup.getPoints());
		loyaltyPointsInfo.setAmount(amount);
		loyaltyPointsInfo.setOrder(order);
	}

	protected LoyaltyPointsInfo getLoyaltyPointsInfo() throws Exception {
		if (isLoggingDebug())
			logDebug("Making a new instance of type: " + getLoyaltyPointsInfoClass());

		LoyaltyPointsInfo lpi = (LoyaltyPointsInfo) Class.forName(getLoyaltyPointsInfoClass()).newInstance();
		return lpi;
	}

	public int runProcess(Object param, PipelineResult result) throws Exception {
		PaymentManagerPipelineArgs params = (PaymentManagerPipelineArgs)param;
		Order order = params.getOrder();
		LoyaltyPointsPaymentGroup loyaltyPointsPaymentGroup = (LoyaltyPointsPaymentGroup)params.getPaymentGroup();
		double amount = params.getAmount();
		
		LoyaltyPointsInfo lpi = getLoyaltyPointsInfo();
		addDataToLoyaltyPointsInfo(order, loyaltyPointsPaymentGroup, amount, params, lpi);

		if (isLoggingDebug())
			logDebug("Putting LoyaltyPointsInfo object into pipeline: " + lpi.toString());

		params.setPaymentInfo(lpi);
		return SUCCESS;
	}

	public int[] getRetCodes() {
		int retCodes[] = {SUCCESS};
		return retCodes;
	}
	
	
}