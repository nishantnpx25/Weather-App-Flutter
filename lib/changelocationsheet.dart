import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeLocationSheet extends StatefulWidget {
  @override
  _ChangeLocationSheetState createState() => _ChangeLocationSheetState();
}

class _ChangeLocationSheetState extends State<ChangeLocationSheet> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Container(
        height: size.height / 2,
        width: size.width,
        padding: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              onSubmitted: (String value) async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white70,
                        title: Text(_controller.text != null
                            ? 'Location Changed'
                            : 'Invalid Location'),
                        content: Text(_controller.text != null
                            ? 'Location changed to ' + _controller.text
                            : 'Please enter a valid location'),
                        actions: [
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context, _controller.text);
                              setState(() {
                                _controller.clear();
                              });
                            },
                          )
                        ],
                      );
                    });
              },
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                  icon: FaIcon(
                    FontAwesomeIcons.searchLocation,
                    color: Colors.white70,
                    size: 20.0,
                  ),
                  hintText: 'Search by city name',
                  hintStyle: TextStyle(color: Colors.white70)),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.blueAccent,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    color: Colors.white70,
                    size: 18.0,
                  ),
                  Text(
                    'Auto Detect Location',
                    style: TextStyle(color: Colors.white70, fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
