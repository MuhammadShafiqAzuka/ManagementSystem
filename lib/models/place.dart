class Place {
  final String id;
  final String name;
  final String location;
  final String pricePerDay;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerDay,
  });

  factory Place.fromJson(String id, Map<String, dynamic> json) {
    return Place(
      id: id,
      name: json['name'],
      location: json['location'],
      pricePerDay: (json['pricePerDay']),
    );
  }
}