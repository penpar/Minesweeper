package two.mine.dto;

public class GameDTO {
	
	private int allCount;//게임횟수
	private int winCount;//승리횟수
	private int maxTime;//최고기록
	private float winPercent;//승률 
	private String userNickName;//닉네임
	private String avataPhoto;//아바타
	
	public String getAvataPhoto() {
		return avataPhoto;
	}
	public void setAvataPhoto(String avataPhoto) {
		this.avataPhoto = avataPhoto;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public float getWinPercent() {
		return winPercent;
	}
	public void setWinPercent(float winPercent) {
		this.winPercent = winPercent;
	}
	public int getAllCount() {
		return allCount;
	}
	public void setAllCount(int allCount) {
		this.allCount = allCount;
	}
	public int getWinCount() {
		return winCount;
	}
	public void setWinCount(int winCount) {
		this.winCount = winCount;
	}
	public int getMaxTime() {
		return maxTime;
	}
	public void setMaxTime(int maxTime) {
		this.maxTime = maxTime;
	}
	
}
