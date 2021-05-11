import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String key = "47c4c66ae7f9940fb44e9736b1d66b9a";

  void getLocation() async {
    Location location = new Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    Location location1 = new Location();
    await location1.getCurrentLocation();
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location1.latitude}&lon=${location1.longitude}&appid=${key}");
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var decodedData = jsonDecode(data);

      double temp = decodedData['main']['temp'];
      int id = decodedData['weather'][0]['id'];
      String nameCity = decodedData['name'];

      print(temp);
      print(id);
      print(nameCity);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
