import 'dart:convert';
import 'package:notesapp/model/openai_model.dart';
import 'package:notesapp/model/usage_model.dart';
import 'package:notesapp/constants/open_ai.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RecommendationService {
  static Future<GPTData> getRecommendation({
    required String rangkuman,
    // required String budget,
  }) async {
    late GPTData gptData = GPTData(
      id: "",
      object: "",
      created: 0,
      model: "",
      choices: [],
      usage: UsageData(
        promptToken: 0,
        completionToken: 0,
        totalTokens: 0,
      ),
    );

    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Charset": "utf-8",
        "Authorization": "Bearer $apiKey",
      };

      String promptData =
          "Buatkan rangkuman berdasarkan teks berikut $rangkuman";

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 200,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        gptData = gptDataFromJson(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return gptData;
  }
}
