import 'dart:convert';

import 'package:flagle/data/models/country.dart';
import 'package:flutter/services.dart';

class CountryRepository {
  Future<List<Country>> getCountries() async {
    List<Country> countries = [];
    try {
      var json = await rootBundle.loadString('assets/data/countries.json');
      var data = jsonDecode(json);
      for (var i = 0; i < data.length; i++) {
        var country = Country(
            name: data[i]['Country'],
            flagSrc: data[i]['ImageURL'],
            latitude: data[i]['lat'],
            longitude: data[i]['lon']);
        countries.add(country);
      }
      return countries;
    } on Error {
      throw ("Could not load countrires");
    }
  }
}
