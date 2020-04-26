import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import '../constants.dart';

class Search extends SearchDelegate {
  final List countryList;
  Search({
    this.countryList,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: primaryBlack,
      brightness: DynamicTheme.of(context).brightness,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
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
                        suggestionList[index]['country'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.network(
                        suggestionList[index]['countryInfo']['flag'],
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
                          'CONFIRMED : ${suggestionList[index]['cases']}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ACTIVE : ${suggestionList[index]['active']}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'RECOVERED : ${suggestionList[index]['recovered']}',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'DEATHS : ${suggestionList[index]['deaths']}',
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
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
    );
  }
}
