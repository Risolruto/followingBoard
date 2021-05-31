package com.vam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vam.model.BoardVO;
import com.vam.model.Criteria;
import com.vam.model.PageMakerDTO;
import com.vam.service.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService bservice;
	//게시판 목록 페이지 접속
	
	/*
	@GetMapping("/list")
	public void boardListGet(Model model) {
		log.info("게시판 목폭 페이지 진입");
		
		model.addAttribute("list",bservice.getList());
	}
	*/
	
	/*
	@GetMapping("/list")
	public void boardListGet(Model model, Criteria cri) {
		log.info("boardListGet");
		
		model.addAttribute("list", bservice.getListPaging(cri));
	}
	*/
	
	/* 게시판 목록 페이지 접속(페이징 적용) */
    @GetMapping("/list")
    public void boardListGET(Model model, Criteria cri) {
        
        log.info("boardListGET");
        
        model.addAttribute("list", bservice.getListPaging(cri));
        
        int total = bservice.getTotal(cri);
        
        PageMakerDTO pageMake = new PageMakerDTO(cri, total);
        
        model.addAttribute("pageMaker", pageMake);
		/* PageMakerDTO를 view로 보내기 위해 addAttribute메소드를 활용하여 pageMaker속성에 저장 */
        
    }    
 
	
	//게시판 등록 페이지 접속
	@GetMapping("/enroll")
	public void boardEnrollGet() {
		log.info("게시판 등록 페이지 진입");
	}
	
	//게시판 등록
	//redirectAttributes 게시판 목록 화면으로 이동시에 등록 성공 여부를 알리는 문자를 같이 전송하기 위함
	@PostMapping("/enroll")
	public String boardEnrollPost(BoardVO board, RedirectAttributes rttr) {
		log.info("BoardVO: "+ board);
		bservice.enroll(board);
		
		rttr.addFlashAttribute("result", "enrol success");
		//일회성으로만 데이터를 전달하기 위해 addFlashAttribute를 사용
		 return "redirect:/board/list";
	}
	
	//게시판 조회
	@GetMapping("/get")
	public void boardPageGet(int bno, Model model, Criteria cri) {
		 // get.jsp 뷰에서 form으로 전송하는 pageNum, amount데이터를 사용할수있도록 정의되어있는 변수들의 클래스를 파라미터로 부여
		
		model.addAttribute("pageInfo", bservice.getPage(bno));
		model.addAttribute("cri", cri);
		//addAttribute 메소드를 호출하여 "cri" 속성명에 속성값으로 뷰(view)로부터 전달받은 Criteria 인스턴스를 저장합니다.
	}
	
	//게시판 수정시에는 2개의 url매핑이 필요 : 조회->수정, 수정->완료
	/* 수정 페이지 이동*/
	@GetMapping("/modify")
	public void boardModifyGet(int bno, Model model, Criteria cri) {
		model.addAttribute("pageInfo", bservice.getPage(bno));
		model.addAttribute("cri", cri);
	}
	
	@PostMapping("/modify")
	public String boardModifyPost(BoardVO board, RedirectAttributes rttr) {
			//수정될 내용의 데이터를 가져오기 위해 BoardVO클래스를 파라미터로 부여,
			//수정 기능 실행 후 리다이렉트 방식으로 리스트 페이지 이동시 데이터를 같이 전송하기 위해 redirectAttributes객체를 받음
		bservice.modify(board);
		
		rttr.addFlashAttribute("result","modify success"); //페이지 이동시 수정이 완료되었음을 알리는 경고창을 위해
		//modify success스트링 데이터를 result 속성 값에 저장하는 메소드
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/delete")
	public String boardDeletePost(int bno, RedirectAttributes rttr	) {
		//삭제 쿼리실행하기 위한 번호bno 정보 부여, 수정기능 후 리다이렉트 방식으로 리스트페이지 이동시 필요한 객체를 파라미터로 부여
		bservice.delete(bno);
		
		rttr.addFlashAttribute("result", "delete success"); //리스트 페이지로 이동시 수정이 완료되었음을 알리는 경고창 메세지
		
		return "redirect:/board/list";
	}
	
	
}
