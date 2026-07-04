import 'package:login_with_unite_test_and_clean_architecture/features/cotisation/domain/entities/cotisation_inline_entity.dart';

class CotisationInlineModel extends CotisationInlineEntity {
  const CotisationInlineModel({
    super.id,
    super.year,
    required super.amount,
    required super.isPaid,
    super.paymentDate,
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

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'year': year,
      'amount': amount,
      'is_paid': isPaid,
      'payment_date': paymentDate,
    };
  }
}
