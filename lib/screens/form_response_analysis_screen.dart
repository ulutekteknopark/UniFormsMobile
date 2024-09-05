import 'package:flutter/material.dart';
import '../managers/chart_response_builder.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';
import '../services/form_response_service.dart';
import '../widgets/text_field_responses_widget.dart';

class FormResponseAnalysisScreen extends StatefulWidget {
  final String formId;

  FormResponseAnalysisScreen({required this.formId});

  @override
  _FormResponseAnalysisScreenState createState() =>
      _FormResponseAnalysisScreenState();
}

class _FormResponseAnalysisScreenState
    extends State<FormResponseAnalysisScreen> {
  late FormResponseService _formResponseService;
  late Future<List<FormResponseModel>> _formResponsesFuture;
  late Future<FormModel> _formFuture;

  @override
  void initState() {
    super.initState();
    _formResponseService = FormResponseService(formId: widget.formId);
    _formResponsesFuture = _formResponseService.fetchFormResponses();
    _formFuture = FormResponseService.fetchFormById(widget.formId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEF7FF),
        title: Text('Form Yanıtları Analizi'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<FormResponseModel>>(
        future: _formResponsesFuture,
        builder: (context, responseSnapshot) {
          return FutureBuilder<FormModel>(
            future: _formFuture,
            builder: (context, formSnapshot) {
              if (responseSnapshot.connectionState == ConnectionState.waiting ||
                  formSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (responseSnapshot.hasError || formSnapshot.hasError) {
                return Center(child: Text('Bir hata oluştu'));
              }
              if (!responseSnapshot.hasData || responseSnapshot.data!.isEmpty) {
                return Center(child: Text('Yanıt bulunamadı'));
              }

              final responses = responseSnapshot.data!;
              final form = formSnapshot.data!;

              final chartBuilder = ChartResponsesBuilder(
                responses: responses,
                form: form,
              );

              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFieldResponses(responses: responses, form: form),
                  ...chartBuilder.build(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
