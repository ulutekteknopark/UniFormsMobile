import 'package:deneme2/models/form_component.dart';
import 'package:deneme2/models/radio_button_component.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showAddRadioButtonsDialog(
    BuildContext context, void Function(FormComponent) onAddComponent,
    {RadioButtonComponent? component}) {
  final _titleController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController()
  ];
  final isRequired = ValueNotifier<bool>(false);

  if (component != null) {
    _titleController.text = component.title;
    optionControllers.clear();
    optionControllers.addAll(component.options.map((option) {
      final controller = TextEditingController(text: option);
      return controller;
    }));
    isRequired.value = component.isRequired;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Radyo Düğmeleri Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                    ),
                  ),
                  SizedBox(height: 16),
                  ...optionControllers.map((controller) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'Seçenek',
                        ),
                      ),
                    );
                  }).toList(),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        optionControllers.add(TextEditingController());
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text('Seçenek Ekle'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Zorunlu alan', style: TextStyle(fontSize: 16)),
                      ValueListenableBuilder<bool>(
                        valueListenable: isRequired,
                        builder: (context, value, child) {
                          return Checkbox(
                            value: value,
                            onChanged: (bool? newValue) {
                              isRequired.value = newValue ?? false;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Vazgeç'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      optionControllers
                          .any((controller) => controller.text.isNotEmpty)) {
                    final options = optionControllers
                        .map((controller) => controller.text)
                        .toList();
                    final newComponent = RadioButtonComponent(
                      id: component?.id ?? Uuid().v4(),
                      title: _titleController.text,
                      options: options,
                      isRequired: isRequired.value,
                    );
                    onAddComponent(newComponent);
                    Navigator.pop(context);
                  }
                },
                child: Text('Ekle'),
              ),
            ],
          );
        },
      );
    },
  );
}
