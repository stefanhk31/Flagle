import 'package:flagle/data/models/country.dart';
import 'package:flagle/data/models/distance.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class DistanceRepository {
  Distance getDistance(Country country1, Country country2, Unit unit) {
    final point1 = LatLng(country1.latitude, country1.longitude);
    final point2 = LatLng(country2.latitude, country2.longitude);
    final distanceInMeters =
        SphericalUtil.computeDistanceBetween(point1, point2);

    switch (unit) {
      case Unit.mi:
        return Distance(distance: (distanceInMeters / 1609.344), unit: unit);
      case Unit.km:
        return Distance(distance: (distanceInMeters / 1000), unit: unit);
      case Unit.m:
      default:
        return Distance(distance: distanceInMeters, unit: unit);
    }
  }
}
