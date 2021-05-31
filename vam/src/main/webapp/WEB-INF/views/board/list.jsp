<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
  a{
  	text-decoration : none;
  }
  table{
 	border-collapse: collapse;
 	width: 1000px;    
 	margin-top : 20px;
 	text-align: center;
  }
  td, th{
  	border : 1px solid black;
  	height: 50px;
  }
  th{
  	font-size : 17px;
  }
  thead{
  	font-weight: 700;
  }
  .table_wrap{
  	margin : 50px 0 0 50px;
  }
  .bno_width{
  	width: 12%;
  }
  .writer_width{
  	width: 20%;
  }
  .regdate_width{
  	width: 15%;
  }
  .updatedate_width{
  	width: 15%;
  }
  .top_btn{
  	font-size: 20px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
  }
  .pageInfo{
  	list-style : none;
  	display: inline-block;
    margin: 50px 0 0 100px;  	
  }
  .pageInfo li{
  	float: left;
    font-size: 20px;
    margin-left: 18px;
    padding: 7px;
    font-weight: 500;
  }
 a:link {color:black; text-decoration: none;}
 a:visited {color:black; text-decoration: none;}
 a:hover {color:black; text-decoration: underline;}
  .active{
  	background-color: #cdd5ec;
  }
  .search_area{
    display: inline-block;
    margin-top: 30px;
    margin-left: 260px;
  }
  .search_area input{
  	height: 30px;
    width: 250px;
  }
  .search_area button{
 	width: 100px;
    height: 36px;
  } 
  .search_area select{
  	height: 35px;
  }
   
  </style>
</head>
<body>
<h1>목록페이지입니다.</h1>

<div class="table_wrap">
	<a href="/board/enroll" class="top_btn">게시판 등록</a>
	<table>
		<thead>
			<tr>
				<th class="bno_width">번호</th>
				<th class="title_width">제목</th>
				<th class="writer_width">작성자</th>
				<th class="regdate_width">작성일</th>
				<th class="updatedate_width">수정일</th>
			</tr>
		</thead>
		<c:forEach items="${list}" var="list">
			<tr>
				<td><c:out value="${list.bno}"/></td>
				<td>
					<a class="move" href='<c:out value="${list.bno}"/>'>
						<c:out value="${list.title}"/>
					</a>
				</td>
				<td><c:out value="${list.writer}"/></td>
                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
			</tr>
		</c:forEach>	
	</table>
		
	<div class="search_wrap">
		<div class="search_area">
			<select name="type">
				<option value="" <c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>--</option>
				<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
				<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
				<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
				<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 + 내용</option>
				<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 + 작성자</option>
				<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목 + 내용 + 작성자</option>
			</select>	
			<%-- <c:out>의 3항 연산 경우 기본적으로 상황에 맞는 <option>이 기본적으로 선택되도록 하기 위함. 예를 들어서 '제목' 검색을 통해 페이지를 이동하였을 때 '제목'옵션이 선택되어 있도록 하기 위함	 --%>
			<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
						<!-- 페이지 이동시에도 검색한 키워드 데이터를 계속 남기기 위해 value속성과 값을 부여 -->
			<button>Search</button>
		</div>
	</div>		
	
	<!-- 페이지 인터페이스 작업을 위한 div태그 
			서버로부터 전달받은 pageMaker속성에 지정된 startPage와 endPage를 가지고 c:forEach태그를 활용하여 페이지 번호를 화면에 출력-->
	<div class="pageInfo_wrap" >
		<div class="pageInfo_area">
			<ul id="pageInfo" class="pageInfo">
			
				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
								<!-- 현재 보이는 10개의 페이지 번호 그 이전으로 이동하기 위해 startPage-1삽입 -->
				</c:if>
				
				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
																				<!-- active->현재위치 표시 -> CSS -->
					<!-- a태그로 감싼 href속성의 값은 페이지가 들어가도록 작성-> form태그를 통해 작동 -->
				</c:forEach>
				
				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
							<!-- 현재 보이는 10개의 페이지 번호 그 다음으로 이동하기 위해 endPage + 1삽입 -->
				</c:if>	
				
			</ul>
		</div>
	</div>
	

	<!-- 페이지 번호 구현 -->
	<form id="moveForm" method="get">	
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<!-- 조회/수정 페이지-> 현 페이지로 이동하기 위함 -->
		
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		<!-- 기존의 form태그를 활용하기때문에 태그내에 keyword를 저장할수 있는 input 태그 작성 -->	
		<input type="hidden" name="type" value="${pageMaker.cri.type }">	
	</form>
</div>

<script>
$(document).ready(function(){
	
	let result = '<c:out value="${result}"/>';
	
	checkAlert(result);
	console.log(result);
	
	function checkAlert(result){
		
		if(result === ''){
			return;
		}
		
		if(result === "enrol success"){
			alert("등록이 완료되었습니다.");
		}
		
		if(result === "modify success"){
			alert("수정이 완료되었습니다.");
		}
		
		if(result === "delete success"){
			alert("삭제가 완료되었습니다.");
		}		
	}	
	
});
	let moveForm = $("#moveForm");
	$(".move").on("click", function(e){
		e.preventDefault();
		
		moveForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
		moveForm.attr("action", "/board/get");
		moveForm.submit();
	});

	/* "a태그 동작 멈춤"  =>  
		"<form> 태그 내부 pageNum과 관련된 <input>태그의 vlaue 속성값을 클릭한 <a> 태그의 페이지 번호를 삽입"  => 
		"<form>태그 action 속성 추가 및 '/board/list'을 속성값으로 추가"   =>  
		"<form>태그 서버 전송" */
	$(".pageInfo a").on("click", function(e){
		e.preventDefault();
		moveForm.find("input[name='pageNum']").val($(this).attr("href"));
		moveForm.attr("action", "/board/list");
		moveForm.submit();
		
	});	
	
		 /* 작성한 메서드는 '검색 버튼'을 눌렀을 때 동작하게 됩니다.
		 메서드가 동작을 하게 되면 먼저 버튼의 기능을 막고,
		 사용자가 작성한 'keyword'데이터를<form> 태그 내부에 있는
		 name 속성이 'keyword'인 <input>태그에 저장을 시킵니다.
		 <form>태그 내부 name 속성이 'pageNum'인 <input>에 저장되어 있는 값을 1로 변경한 후 서버로 전송합니다.-> 검색을 통해 목록페이지로 이동했을때 1페이지로 넘어감
		 form 에 actioin을 통해 url을 지정해주지않으면 현재의 url경로의 매핑 메서드를 호출함  */
	$(".search_area button").on("click", function(e){
		e.preventDefault();
		
		let type = $(".search_area select").val();
		let keyword = $(".search_area input[name='keyword']").val();
		
		if(!type){
			alert("검색 종류를 선택하세요.");
			return false;
		}
		
		if(!keyword){
			alert("키워드를 입력하세요.");
			return false;
		}		
		
		moveForm.find("input[name='type']").val(type);
		moveForm.find("input[name='keyword']").val(keyword);
		moveForm.find("input[name='pageNum']").val(1);
		moveForm.submit();
	});
	
</script>

</body>
</html>