import 'package:flutter/material.dart';
import '../managers/form_manager.dart';
import '../models/template_form_model.dart';
import '../widgets/search_field.dart';
import '../widgets/template_form_item.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  late FormManager<TemplateFormModel> templateFormManager;
  String dropdownValue = 'Tüm Şablonlar';
  String dropdownValue1 = 'Oluşturulma Tarihi';

  @override
  void initState() {
    super.initState();
    templateFormManager = FormManager<TemplateFormModel>(onUpdate: () {
      setState(() {});
    });
    templateFormManager.allForms = [
      TemplateFormModel(
          title: 'Restoran Değerlendirme Formu', isStarred: false),
      TemplateFormModel(title: 'İş Başvurusu Formu', isStarred: false),
      TemplateFormModel(title: 'Otel Rezervasyon Formu', isStarred: false),
      TemplateFormModel(title: 'Tıbbi Geçmiş Formu', isStarred: false),
      TemplateFormModel(title: 'Güvenlik Formu', isStarred: false)
    ];
    templateFormManager.filteredForms = templateFormManager.allForms;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        appBarTheme: AppBarTheme(color: Color(0xFFFEF7FF)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Şablonlar',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchFieldWidget(
                searchController: templateFormManager.searchController,
                onChanged: templateFormManager.filterForms,
                hintText: 'Şablon ara',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue, // Use the state variable
                    items: const [
                      DropdownMenuItem(
                        value: 'Tüm Şablonlar',
                        child: Text('Tüm Şablonlar'),
                      ),
                      DropdownMenuItem(
                        value: 'Yıldızlı Şablonlar',
                        child: Text('Yıldızlı Şablonlar'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value ?? 'Tüm Şablonlar';
                        templateFormManager.isStarred =
                            dropdownValue == 'Yıldızlı Şablonlar';
                        templateFormManager.applyFilter();
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: dropdownValue1,
                    items: const [
                      DropdownMenuItem(
                        value: 'Oluşturulma Tarihi',
                        child: Text('Oluşturulma Tarihi'),
                      ),
                      DropdownMenuItem(
                        value: 'Alfabetik Sırala',
                        child: Text('Alfabetik Sırala'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue1 = value ?? 'Oluşturulma Tarihi';
                        if (value == 'Alfabetik Sırala') {
                          templateFormManager.sortAlphabetically();
                        } else if (value == 'Oluşturulma Tarihi') {
                          templateFormManager.sortByDate();
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4 / 3,
                  ),
                  itemCount: templateFormManager.filteredForms.length,
                  itemBuilder: (context, index) {
                    final form = templateFormManager.filteredForms[index];
                    return buildTemplateFormItem(
                        context, form, templateFormManager);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
