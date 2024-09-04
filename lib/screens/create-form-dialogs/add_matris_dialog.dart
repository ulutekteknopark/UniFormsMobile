import 'package:deneme2/models/form_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

import '../../models/matris_component.dart';

void showAddMatrisDialog(
    BuildContext context, void Function(FormComponent) onAddComponent,
    {MatrisComponent? component}) {
  final _headlineController = TextEditingController();
  final _headlineColorController = ValueNotifier<Color>(Colors.grey.shade300);
  final _matrisColorController = ValueNotifier<Color>(Colors.white);
  final _rowNumController = ValueNotifier<int>(2);
  final _colNumController = ValueNotifier<int>(3);
  bool isRequired = false;

  if (component != null) {
    _headlineController.text = component.headline;
    _headlineColorController.value = component.headlineColor;
    _matrisColorController.value = component.matrisColor;
    _rowNumController.value = component.rowNum;
    _colNumController.value = component.colNum;
    isRequired = component.isRequired; // Initialize the boolean value
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Matris Ekle'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _headlineController,
                    decoration: const InputDecoration(
                      labelText: 'Sol Üst Metin',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Başlık Rengi:'),
                      ElevatedButton(
                        onPressed: () {
                          _showColorPicker(context, _headlineColorController);
                        },
                        child: const Text('Rengi Değiştir'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Satır Rengi:'),
                      ElevatedButton(
                        onPressed: () {
                          _showColorPicker(context, _matrisColorController);
                        },
                        child: const Text('Rengi Değiştir'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Satır Sayısı:'),
                      Expanded(
                        child: Slider(
                          value: _rowNumController.value.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: '${_rowNumController.value}',
                          onChanged: (value) {
                            setState(() {
                              _rowNumController.value = value.toInt();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Sütun Sayısı:'),
                      Expanded(
                        child: Slider(
                          value: _colNumController.value.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 4,
                          label: '${_colNumController.value}',
                          onChanged: (value) {
                            setState(() {
                              _colNumController.value = value.toInt();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Zorunlu alan', style: TextStyle(fontSize: 16)),
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
                child: const Text('Vazgeç'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_headlineController.text.isNotEmpty) {
                    final newComponent = MatrisComponent(
                      id: component?.id ?? Uuid().v4(),
                      headline: _headlineController.text,
                      rowNum: _rowNumController.value,
                      colNum: _colNumController.value,
                      headlineColor: _headlineColorController.value,
                      matrisColor: _matrisColorController.value,
                      isRequired: isRequired,
                    );
                    onAddComponent(newComponent);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Ekle'),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showColorPicker(
    BuildContext context, ValueNotifier<Color> colorNotifier) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Renk Seç'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: colorNotifier.value,
            onColorChanged: (color) {
              colorNotifier.value = color;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Seç'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
