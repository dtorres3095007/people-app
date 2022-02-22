class Person {
  final int? id;
  final String name;
  final String lastName;
  final String date;

  Person({
    this.id,
    required this.name,
    required this.lastName,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'date': date,
    };
  }
}
