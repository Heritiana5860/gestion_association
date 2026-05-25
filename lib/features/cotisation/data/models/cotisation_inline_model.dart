class CotisationInlineModel {
  final int? id;
  final int year;
  final double amount;
  final bool isPaid;
  final String paymentDate;

  const CotisationInlineModel({
    this.id,
    required this.year,
    required this.amount,
    required this.isPaid,
    required this.paymentDate,
  });

  factory CotisationInlineModel.fromJson(Map<String, dynamic> json) {
    return CotisationInlineModel(
      id: json['id'] as int?,
      year: json['year'] as int,
      amount: double.parse(json['amount'].toString()),
      isPaid: json['is_paid'] as bool,
      paymentDate: json['payment_date'] as String,
    );
  }
}
