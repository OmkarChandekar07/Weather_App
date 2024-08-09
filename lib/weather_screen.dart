import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/addInfo.dart';
import 'package:weather_app/hrly_forcast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp =0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String,dynamic>> getCurrentWeather() async {
    final res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=47fee6b8fe424959085ecb7d1ae5e254'));
    final data = jsonDecode(res.body);
    return data;
}

     
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                print("Refresh");
              },
              icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: Text(
          "Weather App",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: getCurrentWeather(), 
        builder: (context, snapshot) {
          
          if(snapshot.connectionState== ConnectionState.waiting){
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!; 
        
      final currentTemp = data['list'][0]['main']['temp'];
      final currentSky =data['list'][0]['weather'][0]['main'];
      final pressure =data['list'][0]['main']['pressure'];
      final humid =data['list'][0]['main']['humidity'];
      final wind =data['list'][0]['wind']['speed'];
     
      final time =DateTime.parse(data['list'][0]['dt_txt'].toString(),);
      
        return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "$currentTemp K",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 35),
                        ),
                        Icon(
                          currentSky=='Clear'||currentSky=='Rain'?Icons.sunny:Icons.cloud,
                          size: 60,
                        ),
                        Text(
                          "$currentSky",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Weather Forecast",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:[
                  for(int i=0;i<35;i++)
                  cards(
                   
                    time: DateFormat.Hm().format(time),
                    icon: data['list'][i+1]['weather'][0]['main']=='Clear'||data['list'][i+1]['weather'][0]['main']=='Rain'?Icons.sunny:Icons.cloud,
                    temp:  data['list'][i+1]['main']['temp'].toString(),
                  ),
                ]
                
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Additional Information",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Addinfo(icon: Icons.water_drop, label: 'Humidity', value: '$humid'),
                Addinfo(icon: Icons.air, label: 'Wind', value: '$wind'),
                Addinfo(
                    icon: Icons.beach_access, label: 'Pressure', value: '$pressure')
              ],
            )
          ],
        ),
      );
      },
    ));
  }
}
