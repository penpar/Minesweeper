package two.mine.dto;

import java.util.Date;

public class RankDTO {
	// DB - GAME TABLE에 있는 컬럼들
	private String r_id;
	private String p_success;
	private Date p_date;
	private int p_time;
	private String p_level;
	// 카운터와 승률 구하기 위해 추가한 데이터
	private int count;
	private double percentV;
	// 검색 기능을 통해 랭킹들을 저장하기 위함
	private String nickname;
	private int rankToday;
	private int rankWeek;
	
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getRankToday() {
		return rankToday;
	}
	public void setRankToday(int rankToday) {
		this.rankToday = rankToday;
	}
	public int getRankWeek() {
		return rankWeek;
	}
	public void setRankWeek(int rankWeek) {
		this.rankWeek = rankWeek;
	}
	public double getPercentV() {
		return percentV;
	}
	public void setPercentV(double percentV) {
		this.percentV = percentV;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getR_id() {
		return r_id;
	}
	public void setR_id(String r_id) {
		this.r_id = r_id;
	}
	public String getP_success() {
		return p_success;
	}
	public void setP_success(String p_success) {
		this.p_success = p_success;
	}
	public Date getP_date() {
		return p_date;
	}
	public void setP_date(Date p_date) {
		this.p_date = p_date;
	}
	public int getP_time() {
		return p_time;
	}
	public void setP_time(int p_time) {
		this.p_time = p_time;
	}
	public String getP_level() {
		return p_level;
	}
	public void setP_level(String p_level) {
		this.p_level = p_level;
	}
	
	
	
	
}
