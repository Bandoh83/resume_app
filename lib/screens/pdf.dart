import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:markdown/markdown.dart' as md;
import 'package:iconsax/iconsax.dart';

class PDFScreen extends StatefulWidget {
  final String markdownText;

  const PDFScreen({super.key, required this.markdownText});

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();
    final parsedMarkdown = md.markdownToHtml(widget.markdownText); 

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Header(level: 1, text: "Markdown PDF"),
              pw.Paragraph(text: parsedMarkdown), // Apply Markdown formatting
            ],
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
            icon: Icon(Iconsax.document_download4),
            onPressed: () => _generatePdf(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          widget.markdownText,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
