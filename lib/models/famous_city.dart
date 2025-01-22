class FamousCity {
  final String name;
  final double lat;
  final double lon;

  const FamousCity({
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// List of famous cities as a constant
List<FamousCity> famousCities = const [
  FamousCity(name: 'Addis Ababa', lat: 9.0192, lon: 38.7525),
  FamousCity(name: 'Bahir dar', lat: 28.5833, lon: 37.3878),
  FamousCity(name: 'Gonder', lat: 48.85, lon: 2.3333),
  FamousCity(name: 'Arba Minch', lat: 51.4833, lon: -0.0833),
  FamousCity(name: 'Mekele', lat: 40.7167, lon: -74.0167),
  FamousCity(name: 'Jimma', lat: 35.6833, lon: 51.4167),
];
