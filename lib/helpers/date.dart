import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateDayMonth(DateTime date) {
  final DateFormat dateFormat = DateFormat('dd/MM');
  String formattedDate = dateFormat.format(date);
  return formattedDate;
}

String formatDateSelected(DateTime date) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formattedDate = dateFormat.format(date);
  return formattedDate;
}

String formatTime(String time) {
  final DateFormat timeFormat = DateFormat('HH:mm');
  String formattedTime = timeFormat.format(DateTime.parse('2000-01-01 $time'));
  return formattedTime;
}

String formatDate(String date) {
  final DateFormat dateFormat = DateFormat('dd/MM');
  String formattedDate = dateFormat.format(DateTime.parse(date));
  return formattedDate;
}

String formatFullDate(String date) {
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final RegExp datePattern = RegExp(r'^\d{2}/\d{2}/\d{4}$');

  if (datePattern.hasMatch(date)) {
    return date;
  }

  String formattedDate = dateFormat.format(DateTime.parse(date));
  return formattedDate;
}

String convertToISODate(String date) {
  try {
    final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    DateTime parsedDate = inputFormat.parse(date);
    String formattedDate = outputFormat.format(parsedDate);

    return formattedDate;
  } catch (e) {
    return 'Data inválida';
  }
}

String formatDateTime(String date, String startTime, String endTime) {
  final DateFormat dateFormat = DateFormat('dd/MM');
  final DateFormat timeFormat = DateFormat('HH:mm');

  DateTime startDate = DateTime.parse(date);
  String formattedDate = dateFormat.format(startDate);
  String formattedStartTime =
      timeFormat.format(DateTime.parse('2000-01-01 $startTime'));
  String formattedEndTime =
      timeFormat.format(DateTime.parse('2000-01-01 $endTime'));

  return '$formattedDate - $formattedStartTime - $formattedEndTime';
}

String formatMonthByNumber(DateTime day) {
  String monthText = '';
  switch (day.month) {
    case 1:
      monthText = 'Janeiro';
      break;
    case 2:
      monthText = 'Fevereiro';
      break;
    case 3:
      monthText = 'Março';
      break;
    case 4:
      monthText = 'Abril';
      break;
    case 5:
      monthText = 'Maio';
      break;
    case 6:
      monthText = 'Junho';
      break;
    case 7:
      monthText = 'Julho';
      break;
    case 8:
      monthText = 'Agosto';
      break;
    case 9:
      monthText = 'Setembro';
      break;
    case 10:
      monthText = 'Outubro';
      break;
    case 11:
      monthText = 'Novembro';
      break;
    case 12:
      monthText = 'Dezembro';
      break;
    default:
      break;
  }

  return monthText;
}

String formatDayWeek(DateTime day) {
  String text = '';
  if (day.weekday == DateTime.sunday) {
    text = 'dom';
  } else if (day.weekday == DateTime.monday) {
    text = 'seg';
  } else if (day.weekday == DateTime.tuesday) {
    text = 'ter';
  } else if (day.weekday == DateTime.wednesday) {
    text = 'qua';
  } else if (day.weekday == DateTime.thursday) {
    text = 'qui';
  } else if (day.weekday == DateTime.friday) {
    text = 'sex';
  } else if (day.weekday == DateTime.saturday) {
    text = 'sab';
  }

  return text;
}

String formatTimeSelected(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
}

String formatTimeHourMinute(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
