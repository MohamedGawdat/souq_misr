import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DateHelper {
  static DateTime formatDateTimeToLocalTime(date) {
    // print('date is $date');
    // return (DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC(date).toLocal());
    try {
      DateTime dateParsed = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
          .parseUTC(date.toString())
          .toLocal();

      // print('parsed $dateParsed');
      return dateParsed;
    } catch (e) {
      try {
        var utc = DateTime.parse(date);
        // print(utc.toString()); // 2020-06-11 17:47:35.000Z
        // print(utc.isUtc.toString()); // true
        return utc.toLocal();
      } catch (e) {
        DateTime dateParsedCatch = DateTime.parse(date);
        print('parsed catch $dateParsedCatch');

        return dateParsedCatch;
      }
    }
    // print('ttttttt');
    return (DateFormat("yyyy-MM-ddTHH:mm aaa:ssZ").parseUTC(date).toLocal());
  }

  static String formatDate(
    String? createdDate,
  ) {
    if (createdDate != null) {
      try {
        DateTime dateValue = formatDateTimeToLocalTime(createdDate);
        String formattedDate = DateFormat(
          'dd/MM/yyyy',
          // navigatorKey.currentContext!.fallbackLocale.toString(),
        ).format(dateValue);

        return formattedDate;
      } catch (e) {
        print('error on format time$createdDate');
        return 'غير متاح';
      }
    } else {
      return 'غير متاح';
    }
  }

  static String formatTime(String? time) {
    // print('time is $time');
    try {
      // print('before parsed is $time');
      DateTime parsedDate = formatDateTimeToLocalTime(time);
      // print('parsed Time is $parsedDate');
      DateFormat formatter = DateFormat(
        'hh:mm aaa',
        // navigatorKey.currentContext!.fallbackLocale.toString(),
      );
      return formatter.format(parsedDate);
    } catch (e) {
      return 'خطأ في الوقت';
    }
  }

  static String formatDateAndTime(String? time) {
    try {
      return '${formatDate(time)}  ${formatTime(time!)}';
    } catch (e) {
      return time ?? 'خطأ في الوقت';
    }
  }

  static DateTime dateFromStringToDateTime(
    String? date, {
    bool withLocal = true,
  }) {
    late DateTime parsedDate;
    if (withLocal) {
      parsedDate = formatDateTimeToLocalTime(date);
    } else {
      parsedDate = DateTime.parse(date!);
    }

    return parsedDate;
  }

  static String formatSendToAPITime(DateTime time) {
    return DateFormat('hh:mm:ss', 'en').format(time);
  }

  static String? formatSendToAPIDate(DateTime? date) {
    try {
      return DateFormat('dd-MM-yyyy', 'en').format(date!);
    } catch (e) {
      return null;
    }
  }

  static String? formatSendToAPIDateAndTime(DateTime? date) {
    try {
      return DateFormat('dd-MM-yyyy HH:mm:ss', 'en').format(date!);
    } catch (e) {
      return null;
    }
  }

  static bool isSmallerThanDate(
      {required DateTime startDate, required DateTime endDate}) {
    if (startDate.isBefore(endDate)) {
      return true;
    } else {
      // ToastUtil.showLongToast(message: 'عفوا تاريخ النهاية غير صحيح');
      return false;
    }
  }

  static bool isSmallerThanOrEqualDate(
      {required DateTime startDate, required DateTime endDate}) {
    if (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      return true;
    } else {
      // print('start ${startDate.toString()}');
      // print('end ${endDate.toString()}');
      // ToastUtil.showLongToast(message: 'عفوا تاريخ النهاية غير صحيح');
      return false;
    }
  }
}

class AppDateAndTimeManagement {
  DateTime? dateTime;

  AppDateAndTimeManagement({
    this.dateTime,
  });

  setDateAndTime(DateTime newDate) {
    dateTime = newDate;
  }

  setTime(TimeOfDay newTime) {
    if (dateTime != null) {
      dateTime = DateTime(dateTime!.year, dateTime!.month, dateTime!.day,
          newTime.hour, newTime.minute, 0, 0);
    } else {
      dateTime = DateTime(newTime.hour, newTime.minute, 0, 0);
    }
  }

  setDate(DateTime newDate) {
    if (dateTime != null) {
      dateTime = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        dateTime!.hour,
        dateTime!.minute,
      );
    } else {
      dateTime = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
      );
    }
  }

  get getDateTimeToApi => DateHelper.formatSendToAPIDateAndTime(dateTime);
  get getDateToApi => DateHelper.formatSendToAPIDate(dateTime);
}

// class AppDateAndTimeManagementOld {
//   DateTime? date;
//   TimeOfDay? time;
//
//   void formatUiDate(date) {}
//   AppDateAndTimeManagementOld({
//     this.date,
//   });
//
//   setDate(DateTime newDate) {
//     date = newDate;
//     if (time == null) {
//       setTime(TimeOfDay.fromDateTime(DateTime.now()));
//     }
//   }
//
//   setTime(TimeOfDay newTime) {
//     time = newTime;
//     date ?? DateTime.now();
//     date = DateTime(
//         date!.year, date!.month, date!.day, newTime.hour, newTime.minute, 0, 0);
//   }
//
//   setDateAndTime(DateTime newDate) {
//     date = DateTime(newDate.year, newDate.month, newDate.day, newDate.hour,
//         newDate.minute, 0, 0);
//   }
//
//   get getDateTimeToApi => DateHelper.formatSendToAPIDateAndTime(date!);
//   get getDateToApi => DateHelper.formatSendToAPIDate(date!);
// }
