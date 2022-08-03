class DateHelper {
  int convertMonthStringToInt(String month) {
    if (month == 'Jan') {
      return 1;
    } else if (month == 'Feb') {
      return 2;
    } else if (month == 'Mar') {
      return 3;
    } else if (month == 'Apr') {
      return 4;
    } else if (month == 'May') {
      return 5;
    } else if (month == 'Jun') {
      return 6;
    } else if (month == 'Jul') {
      return 7;
    } else if (month == 'Aug') {
      return 8;
    } else if (month == 'Sep') {
      return 9;
    } else if (month == 'Oct') {
      return 10;
    } else if (month == 'Nov') {
      return 11;
    } else if (month == 'Dec') {
      return 12;
    } else {
      return 0;
    }
  }

  String retrieveMonth(String date) {
    final endIndex = date.indexOf(' ');
    String month = date.substring(0, endIndex);
    return month;
  }

  int retrieveYear(String date) {
    final startIndex = date.indexOf(',') + 2;
    int year = int.parse(date.substring(startIndex).trim());
    return year;
  }
}