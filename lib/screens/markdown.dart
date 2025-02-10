import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:iconsax/iconsax.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class MarkdownPreviewScreen extends StatefulWidget {
  final String markdownText;

  const MarkdownPreviewScreen({super.key, required this.markdownText});

  @override
  MarkdownPreviewScreenState createState() => MarkdownPreviewScreenState();
}

class MarkdownPreviewScreenState extends State<MarkdownPreviewScreen> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.markdownText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final String markdownText = '''
   $Markdown
  ''';


  Future<void> _generatePdf(BuildContext context) async {
  
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              widget.markdownText,
              style: pw.TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'markdown.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Preview"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.visibility : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
          IconButton(
              icon: Icon(Iconsax.document_download4),
              onPressed: () => _generatePdf(context)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isEditing
            ? TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Edit your Markdown content here...",
                ),
                onChanged: (value) {
                  setState(() {});
                },
              )
            : Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Markdown(data: _controller.text),
                ),
              ),
      ),
    );
  }
}
