class Surah {
  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final String name;
  final String arabicName;
  final int versesCount;
  
  const Surah({
    required this.arabicName,
    required this.id,
    required this.name,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
  });
  
  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
    arabicName: json["name_arabic"],
    id: json["id"],
    name: json["name_simple"],
    revelationOrder: json["revelation_order"],
    revelationPlace: json["revelation_place"],
    versesCount: json["verses_count"],
  );
  
  Map<String, dynamic> toMap() => {
    "name_arabic": arabicName,
    "id": id,
    "name_simple": name,
    "revelation_order": revelationOrder,
    "revelation_place": revelationPlace,
    "verses_count": versesCount,
  };
}