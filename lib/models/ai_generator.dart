import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> callGeminiAI(Map<String, dynamic> formData) async {
  final apiKey = 'AIzaSyCc8ABn1XhyXiJ0CFqBlRg11J99Ci3tF4U'; 
  final apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';


  String prompt = '''
  Improve this resume data and make it an impressive CV based on the information given to fit the job market:


  Name: ${formData['name']}
  Role: ${formData['role']}
  About: ${formData['about']}
  Address: ${formData['address']}
  Email: ${formData['email']}
  Phone: ${formData['phone']}
  Languages and Tools: ${formData['languages'].join(', ')}
  Working Experience:
  ${formData['works'].map((work) => '-  ${work['company name']}: ${work['job title']}: ${work['description']}').join('\n')}
  Education:
  ${formData['education'].map((education) => '-  ${education['school name']}: ${education['programme']}').join('\n')}
  ''';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'contents': [{'parts': [{'text': prompt}]}],
      'generationConfig': {'maxOutputTokens': 500},
    }),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData['candidates'][0]['content']['parts'][0]['text'];
  } else {
    throw Exception('Failed to call Gemini AI: ${response.statusCode} - ${response.body}');
  }
}

