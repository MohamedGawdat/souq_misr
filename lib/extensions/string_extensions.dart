extension StringToIntExtension on String? {
  String get toWholeNumber {
    if (this != null) {
      try {
        double number = double.parse(this!);
        return number.toInt().toString();
      } catch (e) {
        return "Invalid Number";
      }
    } else {
      return "Invalid Number";
    }
  }
}
