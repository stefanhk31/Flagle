import 'dart:convert';
import 'dart:math';

import 'package:flagle/data/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'game_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

//TODO: make landing page a load screen, pass answer when initialized into stateful widget
class _LoadingScreenState extends State<LoadingScreen> {
  List<Country> _countries = [];
  int _answerIndex = 0;

  Future<dynamic> readData() async {
    var json = await rootBundle.loadString('assets/data/countries.json');
    return jsonDecode(json);
  }

  Future<void> initCountries() async {
    var data = await readData();
    for (var i = 0; i < data.length; i++) {
      var country = Country(
          name: data[i]['Country'],
          flagSrc: data[i]['ImageURL'],
          latitude: data[i]['lat'],
          longitude: data[i]['lon']);
      _countries.add(country);
    }
    if (_countries.isNotEmpty) {
      _answerIndex = Random().nextInt(_countries.length);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return GameScreen(
              countries: _countries,
              answer: _countries[_answerIndex],
            );
          },
        ),
      );
    }
  }

  @override
  void initState() {
    initCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
