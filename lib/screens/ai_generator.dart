import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> callGeminiAI(Map<String, dynamic> formData) async {
  final apiKey = 'AIzaSyCc8ABn1XhyXiJ0CFqBlRg11J99Ci3tF4U'; 
  final apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';

  String prompt = '''
  Improve this portfolio data and make it an impressive CV:

  Name: ${formData['name']}
  Role: ${formData['role']}
  About: ${formData['about']}
  Address: ${formData['address']}
  Email: ${formData['email']}
  Phone: ${formData['phone']}
  Languages and Tools: ${formData['languages'].join(', ')}
  Working Experience:
  ${formData['works'].map((work) => '-  ${work['company name']}: ${work['job title']}: ${work['job description']}').join('\n')}
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




//   /// Generate PDF with separate content
//   Future<void> generatePDF() async {
//     final pdfData = await HtmlToPdf.convertHtml(getHtmlTemplate());
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/structured_cv.pdf');
//     await file.writeAsBytes(pdfData);

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PdfPreviewScreen(pdfFile: file),
//       ),
//     );
//   }

//   /// Structured PDF Content (Separate from AI Response)
//   String getHtmlTemplate() {
//     return '''
//       <html>
//       <head>
//         <style>
//           body { font-family: Arial, sans-serif; padding: 40px; }
//           h1, h2 { color: #007bff; border-bottom: 2px solid #007bff; padding-bottom: 5px; }
//           p { font-size: 16px; line-height: 1.6; }
//           .page-break { page-break-before: always; }
//         </style>
//       </head>
//       <body>
//         <h1>Professional CV</h1>

//         <!-- Page 1: Profile -->
//         <h2>Profile</h2>
//         <p><strong>Name:</strong> ${widget.formData['name']}</p>
//         <p><strong>Role:</strong> ${widget.formData['role']}</p>
//         <p><strong>About:</strong> ${widget.formData['about']}</p>
//         <p><strong>Address:</strong> ${widget.formData['address']}</p>
//         <p><strong>Email:</strong> ${widget.formData['email']}</p>
//         <p><strong>Phone:</strong> ${widget.formData['phone']}</p>

//         <!-- Page Break -->
//         <div class="page-break"></div>

//         <!-- Page 2: Skills -->
//         <h2>Languages & Tools</h2>
//         <p>${widget.formData['languages'].join(', ')}</p>

//         <!-- Page Break -->
//         <div class="page-break"></div>

//         <!-- Page 3: Work Experience -->
//         <h2>Work Experience</h2>
//         ${widget.formData['works'].map((work) => '''
//           <p><strong>${work['title']}</strong></p>
//           <p>${work['description']}</p>
//           <hr>
//         ''').join('')}

//         <!-- Page Break -->
//         <div class="page-break"></div>

//         <!-- Page 4: Additional Information -->
//         <h2>Additional Notes</h2>
//         <p>This section is reserved for any additional notes or information.</p>
        
//       </body>
//       </html>
//     ''';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Generate CV")),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text("AI Response (Not in PDF):", style: TextStyle(fontWeight: FontWeight.bold)),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text(aiGeneratedText, textAlign: TextAlign.center),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: generatePDF,
//                     child: Text("Generate PDF"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }