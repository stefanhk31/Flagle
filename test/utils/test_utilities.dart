import 'package:flagle/data/models/country.dart';

class TestUtilities {
  static List<Country> generateTestCountries(int count) {
    List<Country> countries = [];
    for (var i = 0; i < count; i++) {
      countries.add(
        Country(
            name: 'Country ${i + 1}',
            flagSrc: '',
            latitude: 0.00,
            longitude: 0.00),
      );
    }
    return countries;
  }

  static Country generateCountry(int number) {
    return Country(
        name: 'Country $number', flagSrc: '', latitude: 0.00, longitude: 0.00);
  }
}
