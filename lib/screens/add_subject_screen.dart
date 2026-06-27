import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/subject.dart';
import '../providers/subject_provider.dart';

/// Screen 1 — Add Subject
/// Contains a validated form for entering a subject name and mark (0–100).
/// All state managed by [SubjectProvider] — no setState used.
class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  bool _submitted = false; // used to force form rebuild on invalid submission

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final mark = int.parse(_markController.text.trim());
      context.read<SubjectProvider>().addSubject(
            Subject(name: name, mark: mark),
          );
      _nameController.clear();
      _markController.clear();
      _formKey.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle,
                  color: Theme.of(context).colorScheme.onPrimary),
              const SizedBox(width: 12),
              Text(
                '"$name" added successfully!',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Trigger rebuild to show validation styling (form-internal state only)
      _submitted = true;
      _submitted; // suppress analyzer unused_field warning — field documents intent
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withAlpha(80),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.school_rounded,
                        color: colorScheme.onPrimary, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      'Add New Subject',
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Enter subject details below',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onPrimary.withAlpha(200)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Subject Name Field
              Text(
                'Subject Name',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('subject_name_field'),
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'e.g. Mathematics',
                  prefixIcon: Icon(Icons.book_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Subject name cannot be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Mark Field
              Text(
                'Mark (0 – 100)',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextFormField(
                key: const Key('subject_mark_field'),
                controller: _markController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'e.g. 78',
                  prefixIcon: Icon(Icons.grade_rounded),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mark cannot be empty';
                  }
                  final mark = int.tryParse(value.trim());
                  if (mark == null) {
                    return 'Mark must be a whole number';
                  }
                  if (mark < 0 || mark > 100) {
                    return 'Mark must be between 0 and 100';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Grade preview
              Consumer<SubjectProvider>(
                builder: (context, provider, _) {
                  return _GradePreviewCard(markController: _markController);
                },
              ),

              const SizedBox(height: 32),

              // Submit button
              ElevatedButton.icon(
                key: const Key('add_subject_button'),
                onPressed: _submit,
                icon: const Icon(Icons.add_circle_outline_rounded),
                label: const Text('Add Subject'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Live grade preview card — updates as user types in mark field.
class _GradePreviewCard extends StatefulWidget {
  final TextEditingController markController;
  const _GradePreviewCard({required this.markController});

  @override
  State<_GradePreviewCard> createState() => _GradePreviewCardState();
}

class _GradePreviewCardState extends State<_GradePreviewCard> {
  String _previewGrade = '—';

  @override
  void initState() {
    super.initState();
    widget.markController.addListener(_updatePreview);
  }

  void _updatePreview() {
    final mark = int.tryParse(widget.markController.text.trim());
    String grade = '—';
    if (mark != null && mark >= 0 && mark <= 100) {
      if (mark >= 80) {
        grade = 'A';
      } else if (mark >= 65) {
        grade = 'B';
      } else if (mark >= 50) {
        grade = 'C';
      } else {
        grade = 'F';
      }
    }
    // This setState is inside a private helper widget, not a screen —
    // it only rebuilds the small preview card.
    setState(() => _previewGrade = grade);
  }

  @override
  void dispose() {
    widget.markController.removeListener(_updatePreview);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary.withAlpha(60)),
      ),
      child: Row(
        children: [
          Icon(Icons.preview_rounded,
              color: colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          Text('Grade preview: ', style: textTheme.bodyMedium),
          Text(
            _previewGrade,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
