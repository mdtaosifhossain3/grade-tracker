import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../theme/app_theme.dart';

/// Screen 3 — Summary
/// Shows total subjects, average mark, and overall grade.
/// Updates live via `Consumer<SubjectProvider>` — no setState.
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<SubjectProvider>(
      builder: (context, provider, _) {
        final total = provider.totalSubjects;
        final avg = provider.averageMark;
        final grade = provider.overallGrade;
        final passing = provider.passingSubjects.length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Overall grade hero card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withAlpha(100),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Overall Result',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onPrimary.withAlpha(200),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withAlpha(30),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: colorScheme.onPrimary.withAlpha(80),
                            width: 3),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        total == 0 ? '—' : grade,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 52,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      total == 0
                          ? 'No subjects added'
                          : _gradeDescription(grade),
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Text('Statistics', style: textTheme.headlineMedium),
              const SizedBox(height: 16),

              // Stats grid
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.library_books_rounded,
                      label: 'Total\nSubjects',
                      value: '$total',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.percent_rounded,
                      label: 'Average\nMark',
                      value: total == 0 ? '—' : avg.toStringAsFixed(1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.check_circle_outline_rounded,
                      label: 'Passing\nSubjects',
                      value: '$passing',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.cancel_outlined,
                      label: 'Failing\nSubjects',
                      value: '${total - passing}',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Subject breakdown (if any)
              if (total > 0) ...[
                Text('Subject Breakdown', style: textTheme.headlineMedium),
                const SizedBox(height: 12),
                ...provider.subjects.map((s) {
                  final sGradeColor =
                      AppTheme.gradeColor(s.grade, colorScheme);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: colorScheme.primary.withAlpha(40)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            s.name,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Progress bar
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: s.mark / 100,
                              backgroundColor:
                                  colorScheme.primary.withAlpha(20),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  sGradeColor),
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${s.mark}',
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: sGradeColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: sGradeColor, width: 1.5),
                          ),
                          child: Text(
                            s.grade,
                            style: TextStyle(
                              color: sGradeColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  String _gradeDescription(String grade) {
    switch (grade) {
      case 'A':
        return 'Excellent Performance';
      case 'B':
        return 'Good Performance';
      case 'C':
        return 'Average Performance';
      default:
        return 'Needs Improvement';
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary, size: 24),
            const SizedBox(height: 12),
            Text(
              value,
              style: textTheme.headlineLarge?.copyWith(
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
