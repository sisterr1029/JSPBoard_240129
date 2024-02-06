<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbss.Bbss" %>
<%@ page import="bbss.BbssDAO" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/custom.css">

  <%--  <link href="WEB-INF/css/bootstrap.css">--%>
  <title>JSP 게시판 웹 사이트</title>
</head>
<body>
  <%
    String userID = null; //로그인이 된 사람들은 로그인 정보를 담을 수 있게 함.
    if (session.getAttribute("userID") != null) { //현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있게 함.
      userID = (String) session.getAttribute("userID"); // 스트링 형변환을 해서 윗줄, 세션에 있는 값을 그대로 가져올 수 있게 함.
    }

    int bbssID = 0;
    if (request.getParameter("bbssID") != null) { // 만약 매개변수로 넘어온 bbssID라는 매개변수가 존재한다면
      bbssID = Integer.parseInt(request.getParameter("bbssID")); // 매개변수의 값을 int로 변환하여 bbssID에 저장됨. 그리고 이 view 서버측에서 사용할 수 있게되는 것임
    }

    if (bbssID == 0) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('유효하지 않은 글입니다.')");
      script.println("location.href = 'bbss.jsp'");
      script.println("</script>"); // bbssID가 아무것도 없다면 alert 발생
    }

    Bbss bbss = new BbssDAO().getBbss(bbssID); // 해당 글에 구체적인 내용을 가져올 수 있게함. 유효한 글이라면 구체적인 정보를 bbss에 담아주게됨.
  %>
<%--  <nav class="navbar navbar-expand-lg bg-body-  tertiary">--%>
<%--    <div class="navbar-header">--%>
<%--      <button type="button" class="navbar-brand" data-toggle="collapse" data-target="#bs=example-navbar-collapse-1" aria-expanded="false">--%>
<%--        <span class="icon-bar"></span>--%>
<%--        <span class="icon-bar"></span>--%>
<%--        <span class="icon-bar"></span>--%>
<%--      </button>--%>
<%--      <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>--%>
<%--    </div>--%>
<%--  </nav>--%>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
    <a class="navbar-brand" href="#">JSP 게시판 웹 사이트</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="main.jsp">메인</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active"  aria-current="page" href="bbss.jsp">게시판</a>
        </li>

      </ul>
      <%
        if(userID == null) { // 즉 로그인이 되어있지 않다면,
      %>
      <ul class="nav navbar-nav navbar-right d-flex">
        <li class="dropdown">
          <a class="nav-link dropdown-toggle caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            접속하기
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
          </ul>
        </li>
      </ul>

      <%
          } else {
      %>

      <ul class="nav navbar-nav navbar-right d-flex">
        <li class="dropdown">
          <a class="nav-link dropdown-toggle caret" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            회원관리
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
          </ul>
        </li>
      </ul>

      <%
        }
      %>
    </div>
  </div>
</nav>
  <div class="container">
    <div class="row">
      <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;" > <%-- table-striped는 테이블 층층 색이 달라보이게 하는 것--%>
        <thead>
          <tr>
            <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="width: 20%; ">글 제목</td>
            <td colspan="2"><%= bbss.getBbssTitle().replaceAll(" ", "%nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
          </tr>
          <tr>
            <td>작성자</td>
            <td colspan="2"><%= bbss.getUserID()%></td>
          </tr>
          <tr>
            <td>작성일자</td>
            <td colspan="2"><%= bbss.getBbssDate().substring(0, 11) + bbss.getBbssDate().substring(11, 13) + "시" + bbss.getBbssDate().substring(14, 16) + "분"%></td>
          </tr>
          <tr>
            <td>내용</td>
            <td colspan="2" style="height: 300px; text-align: left;"><%= bbss.getBbssContent().replaceAll(" ", "%nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
          </tr>
        </tbody>
      </table>
      <div class="flex-column">
        <div style="float: left;">
          <a href="bbss.jsp" class="btn btn-primary m-1">목록</a>
        </div>
      <%
        if(userID != null && userID.equals(bbss.getUserID())) { // 현재 사용자가 글의 작성자가 동일하다면, a링크가 출력이 될 수 있게함.
      %>
        <div style="float: left">
          <a href="update.jsp?bbssID=<%=bbssID%>" class="btn btn-primary m-1" style="float: left;">수정</a> <%-- 해당 글의 작성자가 본인이라면 update에 해당 bbssid를 매개변수로써 가져갈 수 있게함. --%>
          <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbssID=<%=bbssID%>" class="btn btn-danger m-1" style="float: left;">삭제</a>
        </div>
        </div>
      <%
        }
      %>
    </div>
  </div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>