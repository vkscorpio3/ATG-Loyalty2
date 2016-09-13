package loyalty;

import atg.nucleus.GenericService;

public class Queries extends GenericService {

	private String allQuery;
	
	
	public Queries() {
	}


	public String getAllQuery() {
		return allQuery;
	}


	public void setAllQuery(String allQuery) {
		this.allQuery = allQuery;
	}
}
