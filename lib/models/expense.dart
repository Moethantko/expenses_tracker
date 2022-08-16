class Expense {
  String? id;
  String category;
  double price;
  String date;
  int year;
  String month;
  String username;

  Expense(
      {this.id,
      required this.category,
      required this.price,
      required this.date,
      required this.year,
      required this.month,
      required this.username});
}
