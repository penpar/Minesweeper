package two.mine.dto;

import java.util.Date;

public class BanListDTO {

	 private String reason;
	 private Date ban_date;
	 
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public Date getBan_date() {
		return ban_date;
	}
	public void setBan_date(Date ban_date) {
		this.ban_date = ban_date;
	}
	
}
