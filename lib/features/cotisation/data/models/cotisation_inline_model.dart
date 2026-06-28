class CotisationInlineModel {
  final int? id;
  final String? year;
  final double amount;
  final bool isPaid;
  final String? paymentDate;

  const CotisationInlineModel({
    this.id,
    this.year,
    required this.amount,
    required this.isPaid,
    this.paymentDate,
  });

  factory CotisationInlineModel.fromJson(Map<String, dynamic> json) {
    return CotisationInlineModel(
      id: json['id'] as int?,
      year: json['year']?.toString(),
      amount: double.parse(json['amount'].toString()),
      isPaid: json['is_paid'] as bool? ?? false,
      paymentDate: json['payment_date'] as String?,
    );
  }
}
