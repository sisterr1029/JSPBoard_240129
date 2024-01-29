package bbss; // 게시판의 데이터를 관리할 수 있는 자바 빈즈 파일임.

public class Bbss {

    private int bbssID;
    private String bbssTitle;
    private String userID;
    private String bbssDate; //데이터 베이스에선 날짜를 분류하는 타입을 쓰지만 여기에선 일단 string을 쓰도록 함.
    private String bbssContent;
    private int bbssAvailable; //Abailable 이란 현재 글이 삭제되었는지 아닌지 1과 0으로 알려줌. 1은 삭제가 되지 않은 글이고, 0은 삭제가 된 글임.

    public int getBbssID() {
        return bbssID;
    }

    public void setBbssID(int bbssID) {
        this.bbssID = bbssID;
    }

    public String getBbssTitle() {
        return bbssTitle;
    }

    public void setBbssTitle(String bbssTitle) {
        this.bbssTitle = bbssTitle;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getBbssDate() {
        return bbssDate;
    }

    public void setBbssDate(String bbssDate) {
        this.bbssDate = bbssDate;
    }

    public String getBbssContent() {
        return bbssContent;
    }

    public void setBbssContent(String bbssContent) {
        this.bbssContent = bbssContent;
    }

    public int getBbssAvailable() {
        return bbssAvailable;
    }

    public void setBbssAvailable(int bbssAvailable) {
        this.bbssAvailable = bbssAvailable;
    }
}
