
import 'package:intl/intl.dart';

class Utils {
  static String convertDate(DateTime dateTime) {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }
}
