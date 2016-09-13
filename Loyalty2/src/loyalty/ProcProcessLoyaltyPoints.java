package loyalty;

import atg.commerce.order.Order;
import atg.commerce.order.PaymentGroup;
import atg.commerce.*;
import atg.commerce.payment.*;
import atg.commerce.payment.processor.*;

import atg.payment.*;
import atg.payment.storecredit.*;

public class ProcProcessLoyaltyPoints extends ProcProcessPaymentGroup {	
	
	private LoyaltyPointsProcessor loyaltyPointsProcessor = new LoyaltyPointsProcessorImpl();

	
	public PaymentStatus authorizePaymentGroup(PaymentManagerPipelineArgs pParams) throws CommerceException {
		LoyaltyPointsInfo lpi = null;
		try {
			lpi = (LoyaltyPointsInfo)pParams.getPaymentInfo();
		}
		catch (ClassCastException cce) {
			if (isLoggingError())
				logError("Expecting class of type LoyaltyPointsInfo but got: " + pParams.getPaymentInfo().getClass().getName());
			throw cce;
		}
		return loyaltyPointsProcessor.authorize(lpi);
	}
	
	
	public PaymentStatus debitPaymentGroup(PaymentManagerPipelineArgs pParams) throws CommerceException {
		LoyaltyPointsInfo lpi = null;
		try {
			lpi = (LoyaltyPointsInfo)pParams.getPaymentInfo();
		}
		catch (ClassCastException cce) {
			if (isLoggingError())
				logError("Expecting class of type LoyaltyPointsInfo but got: " + pParams.getPaymentInfo().getClass().getName());
			throw cce;
		}
		LoyaltyPointsStatus authStatus = null;
		PaymentGroup pg = pParams.getPaymentGroup();
		try {
			authStatus = (LoyaltyPointsStatus) pParams.getPaymentManager().getLastAuthorizationStatus(pg);
		}
		catch (ClassCastException cce) {
			if (isLoggingError()) {
				String authStatusClassName = pParams.getPaymentManager().getLastAuthorizationStatus(pg).getClass().getName();
				logError("Expecting class of type LoyaltyPointsStatus but got: " + authStatusClassName);
			}
			throw cce;
		}
		return loyaltyPointsProcessor.debit(lpi, authStatus);
	}

	public PaymentStatus creditPaymentGroup(PaymentManagerPipelineArgs pParams) throws CommerceException {
		LoyaltyPointsInfo lpi = null;

		try {
			lpi = (LoyaltyPointsInfo)pParams.getPaymentInfo();
		}
		catch (ClassCastException cce) {
			if (isLoggingError())
				logError("Expecting class of type LoyaltyPointsInfo but got: " + pParams.getPaymentInfo().getClass().getName());
			throw cce;
		}

		PaymentGroup pg = pParams.getPaymentGroup();
		LoyaltyPointsStatus debitStatus = null;
		try {
			debitStatus = (LoyaltyPointsStatus) pParams.getPaymentManager().getLastDebitStatus(pg);
		}
		catch (ClassCastException cce) {
			if (isLoggingError()) {
				String debitStatusClassName = pParams.getPaymentManager().getLastDebitStatus(pg).getClass().getName();
				logError("Expecting class of type LoyaltyPointsStatus but got: " + debitStatusClassName);
			}
			throw cce;
		}
		return loyaltyPointsProcessor.credit(lpi, debitStatus);
	}
}