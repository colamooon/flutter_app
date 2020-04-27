class ErrorMessage {
  static String getValue(int errorCode) {
    switch (errorCode) {
      case 500100:
        return "아이디 또는 비밀번호가 일치하지 않습니다.";
      case 500200:
        return "아이디를 입력해 주세요.";
      case 500201:
        return "암호를 입력해 주세요.";
      case 500202:
        return "암호(확인)를 입력해 주세요.";
      case 500203:
        return "이미 존재하는 아이디 입니다.";
      case 999999:
        return "네트워크 연결상태를 확인해 주세요.";
      default:
        return "네트워크 오류입니다 관리자에 문의 부탁드립니다.";
    }
  }
}
