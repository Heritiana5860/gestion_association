class CollegeEntity {
  final int? id;
  final String nom;
  final String contact;
  final String address;
  final String etablissement;
  final String niveau;
  final String nomPromotion;
  final String year;

  const CollegeEntity({
    this.id,
    required this.nom,
    required this.contact,
    required this.address,
    required this.etablissement,
    required this.niveau,
    required this.nomPromotion,
    required this.year,
  });
}
