import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/form_model.dart';
import '../services/form_response_service.dart';
import '../widgets/form_response_text_fields.dart';

class FormResponseScreen extends StatefulWidget {
  final String formId;

  const FormResponseScreen({required this.formId, Key? key}) : super(key: key);

  @override
  _FormResponseScreenState createState() => _FormResponseScreenState();
}

class _FormResponseScreenState extends State<FormResponseScreen> {
  late Future<FormModel> _formFuture;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _responses = {};
  late FormResponseService _formResponseService;

  @override
  void initState() {
    super.initState();
    _formResponseService = FormResponseService(formId: widget.formId);
    _formFuture = FormResponseService.fetchFormById(widget.formId);
  }

  Future<void> _showSuccessPopup(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarılı!'),
          content: Text('Form yanıtlarınız başarıyla kaydedildi.'),
        );
      },
    );

    await Future.delayed(Duration(seconds: 5));

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  Future<void> _showTimeoutPopup(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Süresi Doldu'),
          content: Text('Bu formun geçerlilik süresi sona ermiştir.'),
        );
      },
    );

    await Future.delayed(Duration(seconds: 10));
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  bool _isFormExpired(DateTime? validUntil) {
    if (validUntil == null) return false;
    return DateTime.now().isAfter(validUntil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Form Yanıtla')),
      ),
      body: FutureBuilder<FormModel>(
        future: _formFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Form yüklenirken hata oluştu'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Form bulunamadı'));
          }

          final form = snapshot.data!;
          final validFrom = form.validFrom;
          final validUntil = form.validUntil;

          // Formun süresi dolmuşsa, kullanıcıyı bilgilendir ve ekranı kapat
          if (_isFormExpired(validUntil)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showTimeoutPopup(context);
            });
            return Center(child: Text('Bu formun geçerlilik süresi sona ermiştir.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (validFrom != null && validUntil != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Form Geçerlilik Süresi: ${validFrom.toString().split(' ')[0]} - ${validUntil.toString().split(' ')[0]}',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        FormResponseTextField(
                          controller: _emailController,
                          labelText: 'E-posta Adresi',
                          validatorMessage: 'E-posta adresi gereklidir',
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: FormResponseTextField(
                                controller: _firstNameController,
                                labelText: 'İsim',
                                validatorMessage: 'İsim gereklidir',
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: FormResponseTextField(
                                controller: _lastNameController,
                                labelText: 'Soyisim',
                                validatorMessage: 'Soyisim gereklidir',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: form.components.length,
                          itemBuilder: (context, index) {
                            final component = form.components[index];
                            return component.buildComponent(
                              onChanged: (value) {
                                _responses[component.id] = value;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 80.0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isFormValid = _formKey.currentState?.validate() ?? false;
                      if (isFormValid) {
                        await _formResponseService.submitForm(
                          email: _emailController.text,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          responses: _responses,
                          formKey: _formKey,
                          formFuture: _formFuture,
                          context: context,
                        );
                        await _showSuccessPopup(context);
                      }
                    },
                    child: Text('Yanıtları Kaydet'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
