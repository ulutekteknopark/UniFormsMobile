import 'package:deneme2/models/check_box_component.dart';
import 'package:deneme2/models/form_component.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showAddCheckboxDialog(
    BuildContext context, void Function(FormComponent) onAddComponent,
    {CheckBoxComponent? component}) {
  final _titleController = TextEditingController();
  final List<TextEditingController> optionControllers = [
    TextEditingController()
  ];
  bool isRequired = false;

  if (component != null) {
    _titleController.text = component.title;
    optionControllers.clear();
    optionControllers.addAll(component.options.map((option) {
      final controller = TextEditingController(text: option);
      return controller;
    }));
    isRequired = component.isRequired;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Onay Kutuları Ekle'),
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
                      Checkbox(
                        value: isRequired,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isRequired = newValue ?? false;
                          });
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
                    final newComponent = CheckBoxComponent(
                      id: component?.id ?? Uuid().v4(),
                      title: _titleController.text,
                      options: options,
                      isRequired: isRequired,
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
