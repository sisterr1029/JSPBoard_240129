<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%--자바스크립트를 문장을 작성하기위해--%>
<%--<% request.setCharacterEncoding("UTR-8"); %> &lt;%&ndash;건너오는 데이터들을 UTF-8으로 받을 수 있게 &ndash;%&gt;--%>
<jsp:useBean id="user" class="user.User" scope="page"/> <%--scope는 현재의 페이지 안에서만 자바빈즈가 사용될 수 있게함. --%>
<jsp:setProperty name="user" property="userID"/> <%--로그인 페이지에서 연계해준 userID를 그대로 받아서 한명의 한 명의 사용자의 userID에 넣어주는 것임.--%>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<%--    <meta name="viewport" content="width=device-width", initial-scale="1">--%>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");

        String userID = null;
        if(session.getAttribute("userID") != null) {//세션을 확인해서 userID라는 이름으로 세션이 존재하는 회원들은 이런식으로 userID에 해당 세션 값을 넣어줄 수 있도록 함.
            userID = (String) session.getAttribute("userID"); //String 형태로 바꿔서 정상적으로 userID라는 변수가 자신에게 할당된 아이디를 담을 수 있도록 만들어줌.
        }
        if(userID != null) {    //userID가 null값이 아닌 경우는 이미 로그인 됨을 출력, 메인링크로 바로 이동케함.
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되어있습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }

        if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다..')");
            script.println("history.back()");
            script.println("</script>"); // null 값일 때 각각의 사용자가 입력하지 않았을 모두의 경우의 수를 체크해줘야함.
        } else {
            UserDAO userDAO = new UserDAO(); // UserDAO라는 하나의 인스턴스를 만들어주고
            int result = userDAO.join(user); //로그인을 시도할 수 있게 함.
            // 이렇게 해서 로그인 페이지에서 userID와 userPassword 가 각각 사용자에 의해 입력이 된 값으로 이 곳으로 넘어와서 그 값을 login함수에 넣어서 실행을 해주는 것임.
            // PrintWriter 란 자바에서 출력 스트림을 다루기 위한 클래스
            // response.getWriter()는 웹에서 클라이언트로 텍스트를 전송하기 위한 출력 스트림을 얻기위한 메소드
            // response는 서블릿이나 JSP에서 사용되는 HttpServletResponse 객체를 나타냄. 이 객체를 통해 서버에서 클라이언트로 데이터 전송이 가능.
            if (result == 1) {
                session.setAttribute("userID", user.getUserID());
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'main.jsp'");
                script.println("</script>");
            } else if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디입니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('데이터베이스 오류가 발생했습니다.')");
                script.println("history.back()");
                script.println("</script>");


//            if (result == -1) {
//                PrintWriter script = response.getWriter();
//                script.println("<script>");
//                script.println("alert('이미 존재하는 아이디입니다.')");
//                script.println("history.back()");
//                script.println("</script>");
//            }
//            else {
//                PrintWriter script = response.getWriter();
//                script.println("<script>");
//                script.println("location.href = 'main.jsp'");
//                script.println("history.back()");
//                script.println("</script>");
            }
        }


    %>
</body>
</html>