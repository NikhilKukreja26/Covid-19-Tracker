import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:pie_chart/pie_chart.dart';

import '../constants.dart';
import '../widgets/world_wide.dart';
import '../widgets/most_affected_countries.dart';
import '../widgets/info_panel.dart';
import '../screens/country_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('COVID-19 TRACKER'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                color: Colors.orange[100],
                height: 100.0,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  Constants.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Worldwide',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              worldData == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : WorldWide(
                      worldData: worldData,
                    ),
              worldData == null
                  ? Container()
                  : PieChart(
                      dataMap: {
                        'Confrimed': worldData['cases'].toDouble(),
                        'Active': worldData['active'].toDouble(),
                        'Recovered': worldData['recovered'].toDouble(),
                        'Deaths': worldData['deaths'].toDouble(),
                      },
                      colorList: [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.grey[900],
                      ],
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              InfoPanel(),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'WE ARE TOGETHER IN THIS FIGHT',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
