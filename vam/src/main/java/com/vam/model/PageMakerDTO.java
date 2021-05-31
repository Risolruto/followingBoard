package com.vam.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageMakerDTO {

	private int startPage; //시작 페이지
	private int endPage; //끝 페이지
	private boolean prev, next; //이전 페이지&다음 페이지 존재 유무
	private int total; // 전체 게시물 수
	private Criteria cri; //현재 페이지, 페이지당 게시물 표시수 정보
	
	//작성한 생성자에선 다음의 순서대로 값들을 계산하여 각 변수를 초기화 한다
	/*생성자*/
	public PageMakerDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
	
		/*마지막 페이지*/
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		/*화면에 보일 끝 번호 구하기.
		  현재 페이지 /10 -> 반올림 (Math.ceil 소수점 나오면 무조건 올림)-> * 10
		 */
		
		/*시작 페이지*/
		this.startPage = this.endPage-9;
		//화면에 표시될 페이지 번호 1~10중 첫번째 페이지 1을 구하기 위해 9를 뺌
		
		
		/*전체 마지막 페이지 계산*/
		int realEnd = (int)(Math.ceil(total *1.0/cri.getAmount()));
		/*현재 게시물 총 개수를 통해 전체 페이지의 마지막 페이지(realEnd)를 구한다
		  전체 페이지(total)을 화면에 표시될 게시물 수 (amount)로 나눈 후 반올림
		  1.0을 곱하는 이유는 int형인 total과 int형인 amount를 나누면 소수점이 나오는 경우를 없애고 정수만 리턴시키기 위함.
		 */
		
		
		/*전체 마지막 페이지(realend)가 화면에 보이는 마지막페이지 (endPage)보다 작은 경우, 보이는 페이지(endPage)값 조정
		  => 화면에 보여질 마지막 페이지 유효한지 체크*/
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		//realEnd가 10단위로 안떨어질 경우 endPage가 realEnd가 되도록 하는 코드
		
		/*시작 페이지 (startPage)값이 1보다 큰 경우 true
		  화면에 보여질 페이지 이전페이지 존재 여부*/
		this.prev = this.startPage>1;
		/*이전 페이지 존재 여부는 시작페이지가 1보다 크면 존재하기 때문에 1페이지가 없다면 그때부터 이전페이지가 생성*/
		
		
		/*마지막 페이지 (endPage)값이 1보가 큰 경우 true
		  화면에 보여질 페이지 다음페이지 존재 여부*/
		this.next = this.endPage < realEnd;
		
	}
}
