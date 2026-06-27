import 'package:flutter/foundation.dart';
import '../models/subject.dart';

/// Holds all subjects and exposes computed stats.
/// State is updated through [addSubject] and [removeSubject].
class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  /// All subjects.
  List<Subject> get subjects => List.unmodifiable(_subjects);

  /// Subjects where grade != 'F' — uses .where() (Class 2 requirement).
  List<Subject> get passingSubjects =>
      _subjects.where((s) => s.isPassing).toList();

  /// Total number of subjects.
  int get totalSubjects => _subjects.length;

  /// Average mark across all subjects; 0.0 if list is empty.
  /// Uses .map() to extract marks (Class 2 requirement).
  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final total =
        _subjects.map((s) => s.mark).reduce((a, b) => a + b);
    return total / _subjects.length;
  }

  /// Overall grade derived from [averageMark].
  String get overallGrade {
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  /// Adds a subject and notifies listeners.
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  /// Removes the subject at [index] and notifies listeners.
  void removeSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }
}
