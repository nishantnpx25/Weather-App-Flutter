import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weatherapp/changelocationsheet.dart';
import 'package:weatherapp/homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var typedName = "Lucknow";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[900],
      body: HomePage(typedName),
      floatingActionButton: SizedBox(
        height: 30.0,
        width: 30.0,
        child: FloatingActionButton(
          tooltip: 'Change City',
          onPressed: () async {
            var nameOfCity = await showModalBottomSheet(
                context: context, builder: (context) => ChangeLocationSheet());
            setState(() {
              typedName = nameOfCity;
            });
          },
          child: FaIcon(
            FontAwesomeIcons.city,
            size: 20.0,
            color: Colors.white70,
          ),
          backgroundColor: Colors.grey[900],
        ),
      ),
    );
  }
}
