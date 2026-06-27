/// Represents a single subject with a name and a mark (0–100).
/// The [_mark] field is private; access it via [mark].
/// The [grade] getter computes a letter grade based on the mark.
class Subject {
  final String name;
  final int _mark;

  // ignore: prefer_initializing_formals — _mark is private; 'this._mark' is not allowed in named params
  Subject({required this.name, required int mark}) : _mark = mark;

  /// Public read-only access to the mark.
  int get mark => _mark;

  /// Returns a letter grade:
  /// A (≥80), B (≥65), C (≥50), F (otherwise).
  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }

  /// Convenience getter — true if the grade is not F.
  bool get isPassing => grade != 'F';
}
