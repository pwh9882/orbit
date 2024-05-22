class UrlParser {
  // UrlParser의 싱글톤 인스턴스
  static final UrlParser _instance = UrlParser._internal();

  // 내부 생성자
  UrlParser._internal();

  // 공용 인스턴스 접근자
  factory UrlParser() {
    return _instance;
  }

  String parse(String input) {
    Uri? uri = Uri.tryParse(input);

    // 스킴이 없는 경우 http 스킴을 추가
    if (uri != null && !uri.hasScheme) {
      uri = Uri.parse('http://$input');
    }

    if (uri != null && uri.hasScheme && uri.hasAuthority) {
      return uri.toString();
    } else {
      return 'https://www.google.com/search?q=$input';
    }
  }
}
