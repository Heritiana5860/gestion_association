class PresidentEntity {
  final int? id;
  final String nom;
  final String contact;
  final String year;
  final String bio;

  const PresidentEntity({
    required this.nom,
    required this.contact,
    required this.year,
    required this.bio,
    this.id,
  });
}
