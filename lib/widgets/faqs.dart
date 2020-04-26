import 'package:flutter/material.dart';
import '../constants.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQs',
        ),
      ),
      body: ListView.builder(
        itemCount: Constants.questionAnswers.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            title: Text(
              Constants.questionAnswers[index]['question'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Constants.questionAnswers[index]['answer'],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
