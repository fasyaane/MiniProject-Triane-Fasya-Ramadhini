import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notesapp/model/openai_model.dart';

class Rangkuman extends StatelessWidget {
  final GPTData gptResponseData;
  const Rangkuman({super.key, required this.gptResponseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF8ABCD7), title: Text('Rangkuman')),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                gptResponseData.choices[0].text,
                textAlign: TextAlign.center,
              )
            ],
          ),
        )));
  }
}
