import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/subject_provider.dart';
import '../widgets/subject_tile.dart';

/// Screen 2 — Subject List
/// Displays all subjects in a ListView.builder with swipe-to-delete via Dismissible.
/// Uses `Consumer<SubjectProvider>` — no setState.
class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<SubjectProvider>(
      builder: (context, provider, _) {
        final subjects = provider.subjects;

        if (subjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.library_books_outlined,
                  size: 80,
                  color: colorScheme.primary.withAlpha(80),
                ),
                const SizedBox(height: 16),
                Text(
                  'No subjects yet',
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface.withAlpha(160),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap "Add Subject" to get started',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withAlpha(120),
                  ),
                ),
              ],
            ),
          );
        }

        // Stats bar at top
        final passing = provider.passingSubjects.length;
        final total = subjects.length;

        return Column(
          children: [
            // Summary strip
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: colorScheme.primary.withAlpha(60), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatChip(
                    label: 'Total',
                    value: '$total',
                    icon: Icons.list_alt_rounded,
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: colorScheme.primary.withAlpha(40),
                  ),
                  _StatChip(
                    label: 'Passing',
                    value: '$passing',
                    icon: Icons.check_circle_outline_rounded,
                  ),
                  Container(
                    width: 1,
                    height: 32,
                    color: colorScheme.primary.withAlpha(40),
                  ),
                  _StatChip(
                    label: 'Failing',
                    value: '${total - passing}',
                    icon: Icons.cancel_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Subject list with swipe-to-delete
            Expanded(
              child: ListView.builder(
                key: const Key('subjects_list'),
                itemCount: subjects.length,
                padding: const EdgeInsets.only(bottom: 16),
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return Dismissible(
                    key: Key('subject_${subject.name}_$index'),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      context.read<SubjectProvider>().removeSubject(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '"${subject.name}" removed',
                            style: TextStyle(color: colorScheme.onPrimary),
                          ),
                          backgroundColor: colorScheme.error,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    background: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.delete_rounded,
                              color: colorScheme.onError, size: 28),
                          const SizedBox(height: 4),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: colorScheme.onError,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    child: SubjectTile(subject: subject),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: colorScheme.primary, size: 18),
        const SizedBox(height: 2),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
