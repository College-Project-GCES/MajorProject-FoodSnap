class Album {
  final String name;
   final int percentage;

  const Album({
    required this.name,
    required this.percentage,

  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      percentage: json['percentage'],
     
    );
  }
}