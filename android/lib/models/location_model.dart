class Location {
  final int id;
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      // typo from the back-end team, should be 'latitude'
      //latitude: json['latitude'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}
