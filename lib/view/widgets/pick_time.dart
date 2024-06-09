import 'package:flutter/material.dart';

Future<void> pickTime(
    BuildContext context, TextEditingController controller) async {
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    final now = DateTime.now();
    final selectedTime =
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    final formattedTime =
        "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
    controller.text = formattedTime;
  }
}
