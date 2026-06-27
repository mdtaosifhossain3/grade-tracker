import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../theme/app_theme.dart';

/// A single row in the Subject List showing name, mark, and grade badge.
class SubjectTile extends StatelessWidget {
  final Subject subject;

  const SubjectTile({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gradeColor = AppTheme.gradeColor(subject.grade, colorScheme);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Grade Badge
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: gradeColor.withAlpha(30),
                border: Border.all(color: gradeColor, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                subject.grade,
                style: TextStyle(
                  color: gradeColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Subject name + passing badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        subject.isPassing
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        size: 14,
                        color: subject.isPassing
                            ? AppTheme.gradeColor('A', colorScheme)
                            : colorScheme.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subject.isPassing ? 'Passing' : 'Failing',
                        style: textTheme.bodySmall?.copyWith(
                          color: subject.isPassing
                              ? AppTheme.gradeColor('A', colorScheme)
                              : colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Mark chip
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: colorScheme.primary.withAlpha(80), width: 1),
              ),
              child: Text(
                '${subject.mark}/100',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
