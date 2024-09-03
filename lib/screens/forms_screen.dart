import 'package:flutter/material.dart';

import '../managers/form_manager.dart';
import '../models/form_model.dart';
import '../services/form_firebase_service.dart';
import '../widgets/form_item.dart';
import '../widgets/search_field.dart';
import 'create_form.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({Key? key}) : super(key: key);

  @override
  _FormsScreenState createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  late FormManager<FormModel> formManager;
  late String dropDownValue = 'Oluşturulma tarihi';
  final FormFirebaseService firebaseService = FormFirebaseService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    formManager = FormManager<FormModel>(onUpdate: () {
      setState(() {});
    });

    fetchUserForms();
  }

  Future<void> fetchUserForms() async {
    setState(() {
      isLoading = true;
    });
    try {
      final userForms = await firebaseService.fetchUserForms();
      setState(() {
        formManager.allForms = userForms;
        formManager.filteredForms = userForms;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEF7FF),
        title: Text(
          'Formlar',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SearchFieldWidget(
                        searchController: formManager.searchController,
                        onChanged: formManager.filterForms,
                        hintText: 'Form ara',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Wrap(
                            spacing: 8.0,
                            children: [
                              FilterChip(
                                label: const Text('Hepsi'),
                                selected: !formManager.isStarred,
                                onSelected: (bool value) {
                                  setState(() {
                                    formManager.isStarred = false;
                                    formManager.applyFilter();
                                  });
                                },
                              ),
                              FilterChip(
                                label: const Text('Yıldızlı'),
                                selected: formManager.isStarred,
                                onSelected: (bool value) {
                                  setState(() {
                                    formManager.isStarred = true;
                                    formManager.applyFilter();
                                  });
                                },
                              ),
                            ],
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            value: dropDownValue,
                            items: const [
                              DropdownMenuItem(
                                value: 'Oluşturulma tarihi',
                                child: Text('Oluşturulma tarihi'),
                              ),
                              DropdownMenuItem(
                                value: 'Alfabetik sırala',
                                child: Text('Alfabetik sırala'),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value ?? 'Oluşturulma tarihi';
                                if (value == 'Oluşturulma tarihi') {
                                  formManager.sortByDate();
                                } else if (value == 'Alfabetik sırala') {
                                  formManager.sortAlphabetically();
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: formManager.filteredForms.length,
                          itemBuilder: (context, index) {
                            final form = formManager.filteredForms[index];
                            return buildFormItem(context, form, formManager);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateForm()),
          );
        },
        backgroundColor: const Color(0xFFECE6F0),
        child: const Icon(Icons.add),
      ),
    );
  }
}
