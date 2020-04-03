class ErrorMessage {
  static String getValue(int errorCode) {
    switch (errorCode) {
      case 500100:
        return "아이디 또는 비밀번호가 일치하지 않습니다.";
      default:
        return "네트워크 오류입니다 관리자에 문의 부탁드립니다.";
    }
  }
}
