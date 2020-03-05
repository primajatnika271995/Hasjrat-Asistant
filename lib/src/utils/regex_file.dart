class Regex {
  Regex._();

  static final RegExp _nikRegex = RegExp(
    r'(\d{13,16})',
  );

  static final RegExp _nameRegex = RegExp(
    r'([A-Z]([A-Z]+|\.)(?:\s+[A-Z]([A-Z]+|\.))*(?:\s+[A-Z][A-Z\-]+){0,2}\s+[A-Z]([A-Z]+|\.))',
  );

  static String isValidationNIK(String nik) {
    List<String> nikList = [];

    if (_nikRegex.hasMatch(nik)) {
      Iterable<Match> matches = _nikRegex.allMatches(nik);
      for (Match m in matches) {
        String match = m.group(0);
        nikList.add(match);
      }

      print(_nikRegex.hasMatch(nik));
      return nikList.join();
    }
  }

  static String isValidationName(String name) {
    List<String> nameList = [];

    if (_nikRegex.hasMatch(name)) {
      Iterable<Match> matches = _nameRegex.allMatches(name);
      for (Match m in matches) {
        String match = m.group(0);
        nameList.add(match);
      }

      print(_nameRegex.hasMatch(name));
      return nameList.join();
    }
  }
}