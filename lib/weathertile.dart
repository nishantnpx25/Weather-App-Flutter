import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherTile extends StatelessWidget {
  WeatherTile({this.typeIcon, this.typeName, this.typeValue});

  final IconData typeIcon;
  final String typeName;
  final String typeValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        typeIcon,
        color: Colors.white70,
      ),
      title: Text(
        typeName,
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        typeValue,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
