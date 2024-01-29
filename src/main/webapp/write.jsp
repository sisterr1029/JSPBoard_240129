<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
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
  %>
<%--  <nav class="navbar navbar-expand-lg bg-body-tertiary">--%>
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
      <form method="post" action="writeAction.jsp"> <%--액션페이지로 보내지는 용도. 보내지는 내용이 숨겨질 수 있도록 post--%>
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd; margin-top:20px;" > <%-- table-striped는 테이블 층층 색이 달라보이게 하는 것--%>
          <thead>
            <tr>
              <th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><input type="text" class="form-control" placeholder="글 제목" name="bbssTitle" maxlength="50"></td>
            </tr>
            <tr>
              <td><textarea class="form-control" placeholder="글 제목" name="bbssContent" maxlength="2048" style="height: 350px;"></textarea></td>
            </tr>
          </tbody>
        </table>
        <div>
          <input type="submit" href="write.jsp" class="btn btn-primary" style="float: right" value="글쓰기">
        </div>
      </form>
    </div>
  </div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>