class MaterialEntity {
  final int? id;
  final String nom;
  final String? description;
  final int? nombreMateriel;

  const MaterialEntity({
    required this.nom,
    this.description,
    this.nombreMateriel,
    this.id,
  });
}
