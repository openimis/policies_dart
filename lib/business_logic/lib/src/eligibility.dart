class Eligibility {
  final String displayName;
  final String code;
  final bool isService;

  Eligibility(
      {required this.displayName, required this.code, required this.isService});

  @override
  String toString() {
    return "Eligibility: $displayName; Code: $code; IsAService: $isService";
  }
}
