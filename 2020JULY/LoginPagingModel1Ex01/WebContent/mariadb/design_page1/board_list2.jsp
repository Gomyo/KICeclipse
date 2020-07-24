<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pageModel1.*"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("utf-8");

	int cpage = 1;
	
	if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
		cpage = Integer.parseInt(request.getParameter("cpage"));
	} else {
		cpage = 1;
	}
	
	// ListDTO 값을 초기화하고 cpage를 집어넣음
	BoardListDTO listDTO = new BoardListDTO();
	listDTO.setCpage(cpage);
	
	BoardDAO dao = new BoardDAO();
	listDTO = dao.boardList(listDTO);
	
	int totalRecord = listDTO.getTotalRecord();
	int totalPage = listDTO.getTotalPage();
	int blockPerPage = listDTO.getBlockPerPage();
	int startBlock = listDTO.getStartBlock();
	int endBlock = listDTO.getEndBlock();
	
	ArrayList<BoardDTO> boardLists = listDTO.getBoardLists();
	StringBuffer strHtml = new StringBuffer();
	
	// 마지막 페이지는 recordPerPage의 영향을 받지 않기 때문에 rs.next로 제한을 둬야 한다 
	for (BoardDTO dto : boardLists) {
		String seq = dto.getSeq();
		String subject = dto.getSubject();
		String writer = dto.getWriter();
		String wdate = dto.getWdate();
		String hit = dto.getHit();
		String emot = dto.getEmot();
		int wgap = dto.getWgap();
	
		strHtml.append("<tr>");
		strHtml.append("<td>&nbsp;</td>");
		strHtml.append("<td>" + seq + "</td>");
		strHtml.append("<td class='left'>");
		// &변수 링크를 넣을 때는 엠퍼샌드 까먹지 말 것
		strHtml.append("<img src='../../images/emoticon/emot" + emot + ".png' width='25'/><a href='board_view1.jsp?cpage="
		+ cpage + "&seq=" + seq + "'>" + subject + "</a>");
		if (wgap == 0) {
			strHtml.append("	&nbsp;<img src='../../images/icon_hot.gif' alt='HOT'>");
		}
		strHtml.append("</td>");
		strHtml.append("<td>" + writer + "</td>");
		strHtml.append("<td>" + wdate + "</td>");
		strHtml.append("<td>" + hit + "</td>");
		strHtml.append("<td>&nbsp;</td>");
		strHtml.append("</tr>");
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/board_list.css">
<script type="text/javascript">
	
</script>
</head>

<body>
	<!-- 상단 디자인 -->
	<div class="con_title">
		<h3>게시판</h3>
		<p>
			HOME &gt; 게시판 &gt; <strong>게시판</strong>
		</p>
	</div>
	<div class="con_txt">
		<div class="contents_sub">
			<div class="board_top">
				<div class="bold">
					총 <span class="txt_orange"><%= totalRecord %></span>건
				</div>
				<div align="right">
					<form action="./login_ok.jsp" method="post" name="loginfrm">
						아이디 
						<input type="text" name="writer" value=""
							class="board_view_input_mail"/> 
						비밀번호 
						<input type="password" name="password" value=""
							class="board_view_input_mail" /> 
							<input type="button" id=loginbtn
							value="로그인" class="btn_write btn_txt01" style="cursor: pointer;" />
					</form>
				</div>
			</div>

			<!--게시판-->
			<div class="board">
				<table>
					<tr>
						<th width="3%">&nbsp;</th>
						<th width="5%">번호</th>
						<th>제목</th>
						<th width="10%">글쓴이</th>
						<th width="17%">등록일</th>
						<th width="5%">조회</th>
						<th width="3%">&nbsp;</th>
					</tr>
					<%=strHtml%>
				</table>
			</div>
			<!--//게시판-->
			<div class="paginate_regular">
				<div align="absmiddle">
					<%
						if (startBlock == 1) {
						out.println("<span><a>&lt;&lt;</a></span>");
					} else {
						out.println("<span><a href='board_list1.jsp?cpage=" + (startBlock - blockPerPage) + "'>&lt;&lt;</a></span>");
					}
					out.println("&nbsp;");

					if (cpage == 1) {
						out.println("<span><a>&lt;</a></span>");
					} else {
						out.println("<span><a href='board_list1.jsp?cpage=" + (cpage - 1) + "'>&lt;</a></span>");
					}
					out.println("&nbsp;&nbsp;");

					for (int i = startBlock; i <= endBlock; i++) {
						if (cpage == i) {
							// span : 줄바꿈을 안하는 태그
							out.println("<span><a>[" + i + "]</a></span>");
						} else {
							out.println("<span><a href='board_list1.jsp?cpage=" + i + "'>" + i + "</a></span>");
						}
					}

					out.println("&nbsp;&nbsp; ");

					if (cpage == totalPage) {
						out.println("<span><a>&gt;</a></span>");
					} else {
						out.println("<span><a href='board_list1.jsp?cpage=" + (cpage + 1) + "'>&gt;</a></span>");
					}

					out.println("&nbsp;");

					if (endBlock == totalPage) {
						out.println("<span><a>&gt;&gt;</a></span>");
					} else {
						out.println("<span><a href='board_list1.jsp?cpage=" + (startBlock + blockPerPage) + "'>&gt;&gt;</a></span>");
					}
					%>
					
					<!--//하단 디자인 -->
</body>
</html>
