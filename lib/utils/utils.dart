import 'package:intl/intl.dart';

class Utilities {
  static String formatedDate(DateTime dateTime) {
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }
}
