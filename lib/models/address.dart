class Address {
  final int? id;
  final String name;
  final int person_id;

  Address({
    this.id,
    required this.name,
    required this.person_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'person_id': person_id,
    };
  }
}
