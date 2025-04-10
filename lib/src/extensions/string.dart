extension StringExtension on String {
  //capitalize the first letter of a string
  String get capitalizeFirst {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
