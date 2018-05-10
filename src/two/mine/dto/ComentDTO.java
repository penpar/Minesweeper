package two.mine.dto;

public class ComentDTO {
	/*request.setAttribute("spage", page);
    request.setAttribute("maxPage", totalPage);
    request.setAttribute("startPage", startPage);
    request.setAttribute("endPage", endPage);*/
	int page;
	int totalPage;
	int startPage;
	int endPage;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	
	
	
}
