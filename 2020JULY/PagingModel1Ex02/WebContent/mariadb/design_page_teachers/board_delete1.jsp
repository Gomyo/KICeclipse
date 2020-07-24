﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pageModel1.*" %>

<%
if(session.getAttribute("s_id") == null) {
	out.println("<script type='text/javascript'>");
	out.println("alert('로그인 해야 합니다.');");
	out.println("location.href='./board_list1.jsp';");
	out.println("</script>");
} 	else {
	
	request.setCharacterEncoding("UTF-8");

	BoardDTO dto = new BoardDTO();
	dto.setSeq(request.getParameter( "seq" ));
	dto.setCpage(request.getParameter("cpage"));
	BoardDAO dao = new BoardDAO();
	dto = dao.boardDelete(dto);
	
	String seq = dto.getSeq();
	String subject = dto.getSubject();
	String writer = dto.getWriter();
	String cpage = dto.getCpage();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
<script type="text/javascript">
	window.onload = function() {
		document.getElementById('dbtn').onclick = function() {
			if (document.dfrm.password.value.trim() == '') {
				alert('비밀번호를 입력해야 합니다.');
				return false;	
			}
			document.dfrm.submit();
		};
	}
</script>
</head>

<body>
<!-- 상단 디자인 -->
<div class="con_title">
	<h3>게시판</h3>
	<p>HOME &gt; 게시판 &gt; <strong>게시판</strong></p>
</div>
<div class="con_txt">
	<form action="./board_delete1_ok.jsp" method="post" name="dfrm">
		<!-- seq 넘기기. 폼 안에 있는것만 넘어갈 수 있기 때문에 hidden으로 해서 값을 넘겨준다. -->
		<input type="hidden" name="seq" value="<%= seq %>" />
		<input type="hidden" name="cpage" value ="<%= cpage %>"/>
		<div class="contents_sub">
			<!--게시판-->
			<div class="board_write">
				<table>
				<tr>
					<th class="top">글쓴이</th>
					<td class="top" colspan="3"><input type="text" name="writer" value="<%= writer %>" class="board_view_input_mail" maxlength="5" readonly/></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="subject" value="<%= subject %>" class="board_view_input" readonly/></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
				</tr>
				</table>
			</div>
			
			<div class="btn_area">
				<div class="align_left">
					<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_list1.jsp?cpage=<%= cpage %>'" />
					<input type="button" value="보기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_view1.jsp?cpage=<%= cpage %>'" />
				</div>
				<div class="align_right">
					<input type="button" id="dbtn" value="삭제" class="btn_write btn_txt01" style="cursor: pointer;" />
				</div>
			</div>
			<!--게시판-->
		</div>
	</form>
</div>
<!-- 하단 디자인 -->

</body>
</html>
<%
}
%>