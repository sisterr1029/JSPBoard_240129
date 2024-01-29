<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbss.BbssDAO" %>
<%@ page import="bbss.Bbss" %>
<%@ page import="java.util.ArrayList" %> <%-- 게시판 목록을 출력하기 위해서 --%>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width", initial-scale="1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/custom.css">

  <%--  <link href="WEB-INF/css/bootstrap.css">--%>
  <title>JSP 게시판 웹 사이트</title>
  <style type="text/css">
    a, a:hover {
      color: #000000;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <%
    String userID = null; //로그인이 된 사람들은 로그인 정보를 담을 수 있게 함.
    if (session.getAttribute("userID") != null) { //현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있게 함.
      userID = (String) session.getAttribute("userID"); // 스트링 형변환을 해서 윗줄, 세션에 있는 값을 그대로 가져올 수 있게 함.
    }
    int pageNumber = 1; // 현재 게시판이 몇번인지 알려주기 위해서. 1이라는 건 기본 페이지를 의미함.--
    if (request.getParameter("pageNumber") != null) { // 파라미터로 pageNumber가 넘어왔다면
      pageNumber = Integer.parseInt(request.getParameter("pageNumber"));  // 여기에는 해당 파라미터의 값이 들어감. 파라미터는 전부 다 정수형으로 만들어주는 pareInt라는 걸 해줘야함.
    }
  %>

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
            <th style="background-color: #eeeeee; text-align: center;">번호</th>
            <th style="background-color: #eeeeee; text-align: center;">제목</th>
            <th style="background-color: #eeeeee; text-align: center;">작성자</th>
            <th style="background-color: #eeeeee; text-align: center;">작성일</th>
          </tr>
        </thead>
        <tbody>
          <%
            BbssDAO bbssDAO = new BbssDAO(); // 게시글을 뽑아올 수 있도록 하나의 인스턴스를 만들어주고
            ArrayList<Bbss> list = bbssDAO.getList(pageNumber); // 리스트를 하나 만들어주고, 현재의 페이지에서 가져온 게시글 목록이 되고,
            for(int i = 0; i < list.size(); i++) { // 가져온 목록을 하나씩 출력함.
          %>
          <tr>
            <td><%= list.get(i).getBbssID()%></td> <%-- 현재 게시글의 정보를 가져올 수 있게 하면 됨.--%>
            <td><a href="view.jsp?bbssID=<%= list.get(i).getBbssID()%>"><%= list.get(i).getBbssTitle().replaceAll(" ", "%nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
            <%-- 해당 게시물 제목을 눌렀을 때에는 해당 게시글에 내용을 보여주는 페이지로 이동해야하기 때문에 view.jsp 로 해당 게시글 번호를 매개변수로 보냄으로써 처리할 수 있도록 함.
            즉, 해당 게시글 번호에 맞는 게시글이 이 view페이지에서 보여질 수 있도록 만들어주는 것임.--%>
            <td><%= list.get(i).getUserID()%></td>
            <td><%= list.get(i).getBbssDate().substring(0, 11) + list.get(i).getBbssDate().substring(11, 13) + "시" + list.get(i).getBbssDate().substring(14, 16) + "분"%></td>
          </tr>
          <%
            }
          %>
        </tbody>
      </table>
      <%
        if(pageNumber != 1) {
      %>
        <div class="flex-column">
          <div>
            <a href="bbss.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success" style="float: left">이전</a>
          </div>
      <%
        } if(bbssDAO.nextPage(pageNumber + 1)) {
      %>
        <div class="flex-column">
          <div>
            <a href="bbss.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success" style="float: left">다음</a>
          </div>
      <%
        }
      %>
          <div>
            <a href="write.jsp" class="btn btn-primary" style="float: right">글쓰기</a>
          </div>
        </div>
<%--      <button type="button" class="btn btn-primary text-secondary">글쓰기</button>--%>
<%--      <div class="col-lg-6 col-sm-12 text-lg-end text-center">--%>
<%--        <button type="button" class="btn btn-primary text-secondary">글쓰기</button>--%>
<%--      </div>--%>
    </div>
  </div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>