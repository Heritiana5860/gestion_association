import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/contants/colors/app_color.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_button.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_input.dart';
import 'package:login_with_unite_test_and_clean_architecture/core/widgets/app_text.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/data/models/event_model.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/event/presentation/providers/event_submit_notifier.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/presentation/widgets/member/dialog_header.dart';

class NewEventDialog extends ConsumerStatefulWidget {
  const NewEventDialog({super.key});

  @override
  ConsumerState<NewEventDialog> createState() => _NewEventDialogState();
}

class _NewEventDialogState extends ConsumerState<NewEventDialog> {
  final formKey = GlobalKey<FormState>();
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  DateTime? _selectedDate;

  String? _apiStartTime;
  String? _apiEndTime;

  final titre = TextEditingController();
  final description = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  final eventDate = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        eventDate.text =
            "${picked.year}-"
            "${picked.month.toString().padLeft(2, '0')}-"
            "${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: 'Heure de début',
      cancelText: 'Annuler',
      confirmText: 'OK',
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
        startTime.text = _formatTimeDisplay(picked);
        _apiStartTime = _formatTimeForApi(picked);
      });
    }
  }

  Future<void> _pickEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: 'Heure de fin',
      cancelText: 'Annuler',
      confirmText: 'OK',
    );
    if (picked != null && picked != _selectedEndTime) {
      // Validation : heure de fin > heure de début
      if (_selectedStartTime != null) {
        final startMinutes =
            _selectedStartTime!.hour * 60 + _selectedStartTime!.minute;
        final endMinutes = picked.hour * 60 + picked.minute;
        if (endMinutes <= startMinutes) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "L'heure de fin doit être après l'heure de début",
                ),
              ),
            );
          }
          return;
        }
      }
      setState(() {
        _selectedEndTime = picked;
        endTime.text = _formatTimeDisplay(picked);
        _apiEndTime = _formatTimeForApi(picked);
      });
    }
  }

  String _formatTimeForApi(TimeOfDay time) {
    if (_selectedDate == null) return '';
    final dt = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      time.hour,
      time.minute,
    );
    return dt.toIso8601String().split('.').first;
  }

  // Garder pour l'affichage UI si besoin
  String _formatTimeDisplay(TimeOfDay time) {
    return time.format(context);
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner une date")),
      );
      return;
    }

    final model = EventModel(
      eventName: titre.text.trim(),
      eventDescription: description.text.trim(),
      eventDate: eventDate.text,
      startTime: _apiStartTime ?? '',
      endTime: _apiEndTime ?? '',
      year: _selectedDate!.year,
    );

    ref.read(newEventProvider.notifier).submitEvent(model: model);
  }

  @override
  void dispose() {
    titre.dispose();
    description.dispose();
    eventDate.dispose();
    startTime.dispose();
    endTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newEvent = ref.watch(newEventProvider);
    final isLoading = newEvent is AsyncLoading;

    ref.listen<AsyncValue<void>>(newEventProvider, (previous, next) {
      if (previous is! AsyncLoading) return;
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColor.red,
              content: AppText(label: "$error", color: AppColor.white),
            ),
          );
        },
        data: (data) {
          ref.read(eventProvider.notifier).refresh();
          context.pop();
        },
      );
    });

    return Dialog(
      backgroundColor: AppColor.scaffoldBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 6.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogHeader(headerTitle: "Evenement"),
              AppInput(
                labelText: "titre",
                enabled: !isLoading,
                controller: titre,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Champ requis" : null,
              ),
              AppInput(labelText: "Description", controller: description),
              AppInput(
                labelText: "Date de l'évenement",
                enabled: !isLoading,
                controller: eventDate,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: _pickDate,
                  icon: Icon(Icons.date_range),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Champ requis" : null,
              ),

              AppInput(
                labelText: "Heure de début",
                enabled: !isLoading,
                controller: startTime,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: _pickStartTime,
                  icon: Icon(Icons.access_time_sharp),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Champ requis" : null,
              ),
              AppInput(
                labelText: "Heure de fin",
                enabled: !isLoading,
                controller: endTime,
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: _pickEndTime,
                  icon: Icon(Icons.access_time_sharp),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Champ requis" : null,
              ),

              SizedBox(height: 6.h),

              AppButton(
                label: isLoading ? "En cours..." : "Enregistrer",
                onPressed: isLoading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
