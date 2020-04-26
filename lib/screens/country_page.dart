import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(countryList: countryData),
              );
            },
          ),
        ],
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    height: 130.0,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                countryData[index]['country'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 50.0,
                                width: 60.0,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'CONFIRMED : ${countryData[index]['cases']}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'ACTIVE : ${countryData[index]['active']}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'RECOVERED : ${countryData[index]['recovered']}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'DEATHS : ${countryData[index]['deaths']}',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey[100]
                                        : Colors.grey[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
