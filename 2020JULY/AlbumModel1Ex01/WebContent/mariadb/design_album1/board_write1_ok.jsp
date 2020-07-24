<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="model1.*" %>

<%
	// 파일 업로드를 위한 코드
	String uploadPath = "C:/Coding/kicjava/2020JULY/AlbumModel1Ex01/WebContent/upload";
	int maxFileSize = 1024 * 1024 * 5;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
	
	BoardDTO dto = new BoardDTO();
	dto.setSubject(multi.getParameter("subject"));
	dto.setWriter(multi.getParameter("writer"));
	dto.setMail("");
	if (!multi.getParameter("mail1").equals("") && !multi.getParameter("mail2").equals("")) {
		dto.setMail(multi.getParameter("mail1") + "@" + multi.getParameter("mail2"));
	}
	dto.setPassword(multi.getParameter("password"));
	dto.setContent(multi.getParameter("content"));
	dto.setWip(request.getRemoteAddr());
	
	String filename = multi.getFilesystemName("upload");
	dto.setFilename(filename);
	
	long filesize = 0;
	File file = multi.getFile("upload");
	// 파일 업로드 된 것이 있을 때 길이 리턴. if처리를 안하면 NPE
	if (file != null) {
		filesize = file.length();
	}
	dto.setFilesize(filesize);
	
	BoardDAO dao = new BoardDAO();
	int flag = dao.boardWriteOk(dto);
	
	out.println("<script type='text/javascript'>");
	if (flag == 0) {
		out.println("alert('글쓰기에 성공했습니다.');");
		out.println("location.href='./board_list1.jsp';");	
	} else {
		out.println("alert('글쓰기에 실패했습니다.');");
		out.println("history.back();");
	}
	
	out.println("</script>");
%>