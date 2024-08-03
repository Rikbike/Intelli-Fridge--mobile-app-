import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TemperaturaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperatura y Humedad'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'bob.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: TemperatureHumidityWidget(),
          ),
        ],
      ),
    );
  }
}

class TemperatureHumidityWidget extends StatefulWidget {
  @override
  _TemperatureHumidityWidgetState createState() => _TemperatureHumidityWidgetState();
}

class _TemperatureHumidityWidgetState extends State<TemperatureHumidityWidget> {
  final DatabaseReference _sensorRef = FirebaseDatabase.instance.ref().child('sensor');
  double? currentTemperature;
  double? currentHumidity;

  @override
  void initState() {
    super.initState();
    _sensorRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          currentTemperature = data['temperature']?.toDouble();
          currentHumidity = data['humidity']?.toDouble();
        });
      } else {
        setState(() {
          currentTemperature = null;
          currentHumidity = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: currentTemperature != null && currentHumidity != null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TemperatureHumidityCard(
            title: 'Temperatura Actual',
            value: '${currentTemperature!.toStringAsFixed(1)} °C',
            color: Colors.blue,
            icon: Icons.thermostat,
          ),
          SizedBox(height: 20),
          TemperatureHumidityCard(
            title: 'Humedad Actual',
            value: '${currentHumidity!.toStringAsFixed(1)} %',
            color: Colors.green,
            icon: Icons.water_drop,
          ),
        ],
      )
          : CircularProgressIndicator(),
    );
  }
}

class TemperatureHumidityCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  TemperatureHumidityCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 50.0, color: color),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 24.0, color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
