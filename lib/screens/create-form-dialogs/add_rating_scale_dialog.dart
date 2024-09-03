import 'package:deneme2/models/form_component.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/rating_scale_component.dart';

void showAddRatingScaleDialog(
    BuildContext context, void Function(FormComponent) onAddComponent,
    {RatingScaleComponent? component}) {
  final _titleController = TextEditingController();
  final _startLabelController = TextEditingController();
  final _endLabelController = TextEditingController();
  int numberOfOptions = 5;
  final isRequired = ValueNotifier<bool>(false); // Yeni özellik

  if (component != null) {
    _titleController.text = component.title;
    _startLabelController.text = component.startLabel;
    _endLabelController.text = component.endLabel;
    numberOfOptions = component.numberOfOptions;
    isRequired.value = component.isRequired; // Yeni özellik
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Derecelendirme Ölçeği Ekle'),
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
                  TextField(
                    controller: _startLabelController,
                    decoration: InputDecoration(
                      labelText: 'Başlangıç Etiketi',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _endLabelController,
                    decoration: InputDecoration(
                      labelText: 'Bitiş Etiketi',
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Seçenek Sayısı'),
                      DropdownButton<int>(
                        value: numberOfOptions,
                        onChanged: (int? newValue) {
                          setState(() {
                            numberOfOptions = newValue ?? 5;
                          });
                        },
                        items: List<int>.generate(10, (index) => index + 1)
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ],
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
                  if (_titleController.text.isNotEmpty) {
                    final newComponent = RatingScaleComponent(
                      id: component?.id ?? Uuid().v4(),
                      title: _titleController.text,
                      startLabel: _startLabelController.text,
                      endLabel: _endLabelController.text,
                      numberOfOptions: numberOfOptions,
                      isRequired: isRequired.value, // Yeni özellik
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
