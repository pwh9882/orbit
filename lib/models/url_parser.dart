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

    if (uri != null && !uri.hasScheme) {
      // 스킴이 없고, 도메인 형식인 경우 http 스킴을 추가
      if (_isDomain(input)) {
        uri = Uri.parse('https://$input');
      }
    }

    if (uri != null && uri.hasScheme && uri.hasAuthority) {
      return uri.toString();
    } else {
      return 'https://www.google.com/search?q=$input';
    }
  }

  // 도메인 형식인지 확인하는 헬퍼 함수
  bool _isDomain(String input) {
    // 도메인 형식을 확인하기 위한 정규 표현식
    final domainRegExp = RegExp(
      r'^(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
    );
    return domainRegExp.hasMatch(input);
  }
}
