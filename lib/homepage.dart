import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'weathertile.dart';

const apiKey = "3a4ff03d31b26762284917e7a0803738";
const url = "http://api.openweathermap.org/data/2.5/weather";
String error = "Loading";

class HomePage extends StatefulWidget {
  final String city;
  HomePage(this.city);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var cityName;
  bool isError = false;

  @override
  void initState() {
    this.getWeather();
    super.initState();
  }

  Future getWeather() async {
    http.Response response =
        await http.get("$url?q=${widget.city.toString()}&appid=$apiKey");

    var results = jsonDecode(response.body);
    setState(() {
      try {
        this.temp = results['main']['temp'] - 273;
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.windSpeed = results['wind']['speed'];
        this.cityName = results['name'];
      } catch (e) {
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getWeather();
    if (isError == true) {
      error = "Invalid";
    }
    //print(error);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 250.0,
            width: 250.0,
            child: FlareActor(
              "assets/WorldSpin.flr",
              fit: BoxFit.contain,
              animation: "roll",
            ),
          ),
        ),
        Center(
          child: Text(
            "Current Weather",
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          ),
        ),
        Center(
          child: Text(
            isError != true ? widget.city.toString() : error,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                WeatherTile(
                  typeIcon: FontAwesomeIcons.thermometerHalf,
                  typeName: 'Temperature',
                  typeValue: isError != true
                      ? temp.toStringAsPrecision(2) + '\u00B0C'
                      : error,
                ),
                WeatherTile(
                  typeIcon: FontAwesomeIcons.cloud,
                  typeName: 'Weather',
                  typeValue: isError != true ? description.toString() : error,
                ),
                WeatherTile(
                  typeIcon: FontAwesomeIcons.sun,
                  typeName: 'Humidity',
                  typeValue: isError != true ? humidity.toString() : error,
                ),
                WeatherTile(
                  typeIcon: FontAwesomeIcons.wind,
                  typeName: 'Wind Speed',
                  typeValue: isError != true ? humidity.toString() : error,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
