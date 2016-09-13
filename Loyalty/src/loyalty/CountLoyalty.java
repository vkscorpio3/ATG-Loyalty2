package loyalty;

import java.util.Iterator;
import java.util.List;

import atg.repository.*;

public class CountLoyalty extends RepositoryPropertyDescriptor {

	@Override
	public Object getPropertyValue(RepositoryItemImpl pItem, Object pValue) {
		if (pValue != null) {
			return pValue;
		}
		int loyaltyAmount = 0;
		List loyaltyTransactionList = (List) pItem.getPropertyValue("loyaltyTransactions");
		Iterator i = loyaltyTransactionList.iterator();
		while (i.hasNext()) {
			RepositoryItem curLoyaltyTransaction = (RepositoryItem) i.next();
			Integer amount = (Integer) curLoyaltyTransaction.getPropertyValue("amount");
			loyaltyAmount += amount.intValue();
		}
		pItem.setPropertyValueInCache(this, loyaltyAmount);
		return new Integer(loyaltyAmount);

	}

	public Class getPropertyType() {
		return Integer.class;
	}

	public boolean isQueryable() {
		return false;
	}

	public boolean isWritable() {
		return false;
	}

}
