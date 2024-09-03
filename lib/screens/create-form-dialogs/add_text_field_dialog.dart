import 'package:deneme2/models/form_component.dart';
import 'package:deneme2/models/text_field_component.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showAddTextFieldDialog(
    BuildContext context, void Function(FormComponent) onAddComponent,
    {TextFieldComponent? component}) {
  final _titleController = TextEditingController();
  bool isRequired = false; // Changed from ValueNotifier<bool> to bool

  if (component != null) {
    _titleController.text = component.title;
    isRequired = component.isRequired; // Initialize the boolean value
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Metin Alanı Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Soru Başlığı',
                    ),
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
                  if (_titleController.text.isNotEmpty) {
                    final newComponent = TextFieldComponent(
                      id: component?.id ?? Uuid().v4(),
                      title: _titleController.text,
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
