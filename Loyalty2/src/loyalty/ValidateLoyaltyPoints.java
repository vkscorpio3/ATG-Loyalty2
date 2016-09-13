package loyalty;

import atg.commerce.order.Order;
import atg.commerce.order.PaymentGroup;
import atg.commerce.order.processor.ValidatePaymentGroupPipelineArgs;
import atg.nucleus.GenericService;
import atg.service.pipeline.PipelineProcessor;
import atg.service.pipeline.PipelineResult;

public class ValidateLoyaltyPoints extends GenericService implements PipelineProcessor {

	private LoyaltySettings loyaltySettings;

	private static int SUCCESS_CODE = 1;
	private static int[] RETURN_CODES = { SUCCESS_CODE };

	public int[] getRetCodes() {
		return RETURN_CODES;
	}

	public int runProcess(Object pParam, PipelineResult pResult) throws Exception {
		
		ValidatePaymentGroupPipelineArgs args;

		args = (ValidatePaymentGroupPipelineArgs) pParam;
		PaymentGroup pg = args.getPaymentGroup();

		try {
			LoyaltyPointsPaymentGroup loyaltyPointsPG = (LoyaltyPointsPaymentGroup) pg;
			int points = loyaltyPointsPG.getPoints();
			double amount = loyaltyPointsPG.getAmount();
			Order order = args.getOrder();
			double orderPrice = order.getPriceInfo().getTotal();

			if (isLoggingDebug())
				logDebug("Applying " + points + " loyalty points " + " to an order totaling " + orderPrice);

			double usersPointsInDollars = points * loyaltySettings.getPointToDollar();

			if (points <= 0)
				pResult.addError("NoPointsUsed", "The number of points should be greater than zero.");

			else if (usersPointsInDollars < amount) {
				pResult.addError("NotEnoughPoints", "You do not have enough points.");
			}
			else if (amount > orderPrice * getLoyaltySettings().getMaxPartOfOrderForLoyalty()) {
				pResult.addError("PointsValueExceeded", "Loyalty points cannot pay for more than "
						+ getLoyaltySettings().getMaxPartOfOrderForLoyalty() + " part of an order.");
			}
			
		} catch (ClassCastException cce) {
			pResult.addError("ClassNotRecognized",
					"Expected a LoyaltyPointsPaymentGroup, but got " + pg.getClass().getName() + " instead.");
		}
		return SUCCESS_CODE;
	}

	public LoyaltySettings getLoyaltySettings() {
		return loyaltySettings;
	}

	public void setLoyaltySettings(LoyaltySettings loyaltySettings) {
		this.loyaltySettings = loyaltySettings;
	}

}
