package com.vam.mapper;

import java.util.List;

import com.vam.model.BoardVO;
import com.vam.model.Criteria;

public interface BoardMapper {

	/* 작가 등록 */
    public void enroll(BoardVO board);
    
    /* 게시판 목록 */
    public List<BoardVO> getList();
    
    public BoardVO getPage(int bno);
    
    public List<BoardVO> getListPaging(Criteria cri);
    //기존의 게시물목록 메소드 역할을 하면서 단지 쿼리만 조금 수정되기때문에 반환타입은 동일하게 List<BoardVO>로 함

    public int modify(BoardVO board);
    
    public int delete (int bno);
    
    /*게시판 총 갯수*/
    public int getTotal(Criteria cri);
}
