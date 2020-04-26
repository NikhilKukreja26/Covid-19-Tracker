import 'package:flutter/material.dart';

class WorldWide extends StatelessWidget {
  final Map worldData;

  const WorldWide({Key key, this.worldData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: '${worldData['cases']}',
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: '${worldData['active']}',
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: '${worldData['recovered']}',
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: '${worldData['deaths']}',
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({
    Key key,
    this.panelColor,
    this.textColor,
    this.title,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: panelColor,
      height: 80.0,
      width: width / 2,
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
