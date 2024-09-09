import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';

Future<void> exportResponsesToPDF(List<FormResponseModel> responses, FormModel form) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Form Yanıtları Analizi', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            ...responses.map((response) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('İsim: ${response.name} ${response.surname}', style: pw.TextStyle(fontSize: 18)),
                  pw.Text('Email: ${response.email}', style: pw.TextStyle(fontSize: 16)),
                  pw.SizedBox(height: 8),
                  pw.Text('Yanıtlar:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...response.responses.entries.map((entry) {
                    final question = form.components.firstWhere((comp) => comp.id == entry.key).title;
                    return pw.Text('$question: ${entry.value}');
                  }).toList(),
                  pw.SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
