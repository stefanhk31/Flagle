// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Unit { mi, km, m }

class Distance {
  num distance;
  Unit unit;

  Distance({
    required this.distance,
    required this.unit,
  });
}
