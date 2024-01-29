package bbss;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbssDAO {
    private Connection conn; //데이터베이스에 접근하게 해주는 하나의 객체.
    private ResultSet rs; // 어떠한 정보를 담을 수 있는 하나의 객체. 결과저장

    public BbssDAO() { // 하나의 객체로 만들었을 때 자동으로 데이터베이스 커넥션이 이루 어질 수 있게 해줘야함.
        try {
            String dbURL = "jdbc:mysql://localhost:3306/BBSS?useUnicode=true&characterEncoding=UTF-8"; // 내 컴퓨터 3306 포트에 BBSS에 접속할 수 있게 해줌. BBSS?serverTimezone=UTC
            String dbID = "root"; // root라는 아이디에 접속할 수 있게 해줌.
            String dbPassword = "0000";
            Class.forName("com.mysql.cj.jdbc.Driver"); // mysql의 드라이버를 찾을 수 있도록함. 드라이버란 mysql에 접속할 수 있도록 매개체역할을 해주는 라이브러리임.
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 커넥션은 드라이버매니저를 통해 url과 id, password를 통해 접속할 수 있도록 한다.
        } catch (Exception e) {
            e.printStackTrace(); // 오류가 무엇인지 출력해주는 것.
        }
    }

    public String getDate() { // 현재의 시간을 가져와주는 함수로써 게시판 글을 작성할 때 현재 서버의 시간을 넣어주는 역할을 함.
        String SQL = "SELECT NOW()"; //현재의 시간을 가져와주는 mysql 의 하나의문장임.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            rs = pstmt.executeQuery(); // 실제로 실행했을 때 나오는 결과를 가져올 수 있또록 함.
            if (rs.next()) {
                return rs.getString(1); // 현재의 날짜를 그대로 반환해줄 수 있도록 함.
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // 빈 문자열을 반환해줌으로써 데이터베이스 오류를 알려줄 수 있도록 함.
    }

    public int getNext() {
        String SQL = "SELECT bbssID FROM BBSS ORDER BY bbssID DESC"; // 1번부터 하나씩 늘어나야 하기 때문에 마지막에 쓰인 글을 가져와서 그 번호에다가 1을 더한 값이 그 다음 글의 번호가 될 수 있도록 함.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            rs = pstmt.executeQuery(); // 실제로 실행했을 때 나오는 결과를 가져올 수 있또록 함.
            if (rs.next()) {
                return rs.getInt(1) + 1; // 나온 결과에 1을 더해줄 수 있도록 함.
            } // 만일 쓰인 게시글이 하나도 없는 경우에는 결과가 나오지 않기 때문에
            return 1; // 이렇게 해줌으로써 첫 번째 게시물엔 1을 반환해준다.
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //
    }

    public int write(String bbssTitle, String userID, String bbssContent) {
        String SQL = "INSERT INTO BBSS VALUES (?, ?, ?, ?, ?, ?)"; // 하나의 게시글을 작성해서 넣어줄 필요가 있기에 bbss테이블 안에 총 6개의 인자가 들어갈 수 있게 해야함.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setInt(1, getNext()); //PreparedStatement에서 하나씩 값을 넣어줄 수 있도록 함.
            pstmt.setString(2, bbssTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbssContent);
            pstmt.setInt(6, 1); // 처음에 글을 작성했을 때 글이 보여져야하는 상태이기 때문에 1을 넣어줌.

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 그렇지 않은 경우에는 -1을 반환함.
    }

    public ArrayList<Bbss> getList(int pageNumber) { //특정한 리스트를 담아서 반환하게 해줄 수 있도록 만든다. 특정한 페이지에 따른 총 10개의 게시글을 가져올 수 있도록 만든 함수.
        String SQL = "SELECT * FROM BBSS WHERE bbssID < ? AND bbssAvailable = 1 ORDER BY bbssID DESC LIMIT 10"; // 1번부터 하나씩 늘어나야 하기 때문에 마지막에 쓰인 글을 가져와서 그 번호에다가 1을 더한 값이 그 다음 글의 번호가 될 수 있도록 함.
        // ㅇㅋ 이해함 bbssID 값이 0이 아닌 애들만 limit 10개까지만 거는 거임. DESC는 내림차순임
        ArrayList<Bbss> list = new ArrayList<Bbss>();// Bbss라는 클래스에서 나오는 인스턴스들을 보관할 수 있는 리스트를 하나 만들어줌. <Bbss>를 넣어줌으로써.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // getNext > 만약에 게시글이 5개면 6이 올 거고 pageNumber는 자동으로 1임. 6-(1-1)*10 이기때문에 6이 담김.
            rs = pstmt.executeQuery(); // 실제로 실행했을 때 나오는 결과를 가져올 수 있또록 함.
            while (rs.next()) { // 결과가 나올 때마다 이런 식으로
                Bbss bbss = new Bbss();
                bbss.setBbssID(rs.getInt(1));
                bbss.setBbssTitle(rs.getString(2));
                bbss.setUserID(rs.getString(3));
                bbss.setBbssDate(rs.getString(4));
                bbss.setBbssContent(rs.getString(5));
                bbss.setBbssAvailable(rs.getInt(6));
                list.add(bbss); // list에 해당 인스턴스를 반환할 수 있게 함.
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list; //출력
    }

    public boolean nextPage(int pageNumber) { // 게시글이 10개라면 다음페이지가 없어야함. 그래서 만든 기능. 그리고 요 함수는 페이징 처리를 위해서 만들어진 함수이기도 함.
        String SQL = "SELECT * FROM BBSS WHERE bbssID < ? AND bbssAvailable = 1 ORDER BY bbssID DESC LIMIT 10";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // getNext > 만약에 게시글이 5개면 6이 올 거고 pageNumber는 자동으로 1임. 6-(1-1)*10 이기때문에 6이 담김.
            rs = pstmt.executeQuery(); // 실제로 실행했을 때 나오는 결과를 가져올 수 있또록 함.
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Bbss getBbss(int bbssID) { // 특정한 아이디에 해당하는 게시글을 가져올 수 있도록 함.
        String SQL = "SELECT * FROM BBSS WHERE bbssID = ?"; // bbssID가 어떤 특정한 숫자인 경우 밑의 행위를 시행할 수 있게 해줌.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setInt(1, bbssID); // bbssID가 1이든 7이든 이런 식으로 값을 넣어서 그 숫자에 해당하는 게시글을 그대로 가져옴.
            rs = pstmt.executeQuery(); // 실제로 실행했을 때 나오는 결과를 가져올 수 있또록 함.
            if (rs.next()) {
                Bbss bbss = new Bbss();
                bbss.setBbssID(rs.getInt(1));
                bbss.setBbssTitle(rs.getString(2));
                bbss.setUserID(rs.getString(3));
                bbss.setBbssDate(rs.getString(4));
                bbss.setBbssContent(rs.getString(5));
                bbss.setBbssAvailable(rs.getInt(6));
                return bbss; // 결과로 나온 각각의 아이디 제목 6개의 변수를 다 받고 bbss 인스턴스에 넣고 그대로 이 함수를 불러온 대상한테 반환해줌.
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(int bbssID, String bbssTitle, String bbssContent) { // 특정한 번호에 매개변수에 들어온 제목과 내용으로 바꿔치기 해주겠다는듯.
        String SQL = "UPDATE BBSS SET bbssTitle = ?, bbssContent = ? WHERE bbssID = ?"; // bbssID 값을 넣어줌으로써 특정한 아이디에 해당하는 제목과 내용을 바꿔주겠다는 얘기
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setString(1, bbssTitle); //PreparedStatement에서 하나씩 값을 넣어줄 수 있도록 함.
            pstmt.setString(2, bbssContent);
            pstmt.setInt(3, bbssID);

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 그렇지 않은 경우에는 -1을 반환함.
    }

    public int delete(int bbssID) {
        String SQL = "UPDATE BBSS SET bbssAvailable = 0 WHERE bbssID = ?"; // bbssID 값을 넣어줌으로써 특정한 아이디에 해당하는 글을 0으로 만들어줌으로써 로그는 남기되 화면상에는 보이지 않도록 함.
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL); // 현재 연결되는 conn 객체를 이용해서 SQL 문장을 실행준비단계로 만들어줌.
            pstmt.setInt(1, bbssID); //ID를 0으로 넣어줌으로써 해당 글은 안보이게됨.
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 그렇지 않은 경우에는 -1을 반환함.
    }
}
