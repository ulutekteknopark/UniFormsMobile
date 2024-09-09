import 'package:deneme2/models/check_box_component.dart';
import 'package:deneme2/models/form_component.dart';
import 'package:deneme2/models/matris_component.dart';
import 'package:deneme2/models/radio_button_component.dart';
import 'package:deneme2/models/text_field_component.dart';
import 'package:flutter/material.dart';
import '../models/dropdown_menu_component.dart';
import '../models/rating_scale_component.dart';
import '../screens/create-form-dialogs/add_checkbox_dialog.dart';
import '../screens/create-form-dialogs/add_dropdown_dialog.dart';
import '../screens/create-form-dialogs/add_radio_button_dialog.dart';
import '../screens/create-form-dialogs/add_rating_scale_dialog.dart';
import '../screens/create-form-dialogs/add_text_field_dialog.dart';
import '../screens/create-form-dialogs/edit_title.dart';
import '../screens/create-form-dialogs/add_matris_dialog.dart';
import 'create_form_menu_card.dart';

class EditTab extends StatefulWidget {
  final String initialFormTitle;
  final void Function(List<FormComponent>) onComponentsChanged;
  final List<FormComponent> components;
  final void Function(String) onTitleChanged;
  final void Function(DateTime?, DateTime?) onDatesChanged;
  final DateTime? validFrom;
  final DateTime? validUntil;

  EditTab({
    required this.initialFormTitle,
    required this.onComponentsChanged,
    required this.components,
    required this.onTitleChanged,
    required this.onDatesChanged,
    this.validFrom,
    this.validUntil,
    Key? key,
  }) : super(key: key);

  @override
  EditTabState createState() => EditTabState();
}

class EditTabState extends State<EditTab> {
  late String formTitle;
  late List<FormComponent> components;
  DateTime? validFrom;
  DateTime? validUntil;

  @override
  void initState() {
    super.initState();
    formTitle = widget.initialFormTitle;
    components = widget.components;
    validFrom = widget.validFrom;
    validUntil = widget.validUntil;
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          validFrom = picked;
        } else {
          validUntil = picked;
        }
        widget.onDatesChanged(validFrom, validUntil);
      });
    }
  }

  void _addComponent(FormComponent component) {
    setState(() {
      components.add(component);
      widget.onComponentsChanged(components);
    });
  }

  void _updateComponent(FormComponent updatedComponent) {
    setState(() {
      final index = components.indexWhere((c) => c.id == updatedComponent.id);
      if (index != -1) {
        components[index] = updatedComponent;
        widget.onComponentsChanged(components);
      }
    });
  }

  void _deleteComponent(FormComponent component) {
    setState(() {
      components.removeWhere((c) => c.id == component.id);
      widget.onComponentsChanged(components);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                createFormMenuCard(
                  context: context,
                  onAddTextField: () =>
                      showAddTextFieldDialog(context, _addComponent),
                  onAddCheckboxes: () =>
                      showAddCheckboxDialog(context, _addComponent),
                  onAddRadioButtons: () =>
                      showAddRadioButtonsDialog(context, _addComponent),
                  onAddDropdown: () =>
                      showAddDropdownDialog(context, _addComponent),
                  onAddRatingScale: () =>
                      showAddRatingScaleDialog(context, _addComponent),
                  onAddMatris: () =>
                      showAddMatrisDialog(context, _addComponent),
                );
              },
              icon: Icon(Icons.add, color: Colors.white),
              label:
              Text('Bileşen Ekle', style: TextStyle(color: Colors.white)),
              style:
              ElevatedButton.styleFrom(backgroundColor: Color(0xFF65558F)),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              editTitleDialog(context, formTitle, (newTitle) {
                setState(() {
                  formTitle = newTitle;
                  widget.onTitleChanged(newTitle);
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  formTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Geçerlilik Başlangıç Tarihi: ${validFrom != null ? validFrom.toString().split(' ')[0] : 'Seçilmedi'}"),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDate(context, true),
          ),
          ListTile(
            title: Text("Geçerlilik Bitiş Tarihi:          ${validUntil != null ? validUntil.toString().split(' ')[0] : 'Seçilmedi'}"),
            trailing: Icon(Icons.calendar_today),
            onTap: () => _selectDate(context, false),
          ),
          SizedBox(height: 20),
          components.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description,
                  size: 80,
                  color: Colors.black54,
                ),
                SizedBox(height: 16),
                Text(
                  'Formunuzda herhangi bir bileşen yok.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                Text(
                  'Form oluşturmak için "Bileşen Ekle" butonuna basınız.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                Text(
                  'Formu kaydetmek için "Ön İzle" ekranındaki "Formu Kaydet" butonuna basınız.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          )
              : Column(
            children: components.asMap().entries.map((entry) {
              FormComponent component = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    component.buildComponent(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            if (component is TextFieldComponent) {
                              showAddTextFieldDialog(context,
                                  _updateComponent,
                                  component: component);
                            } else if (component is CheckBoxComponent) {
                              showAddCheckboxDialog(context,
                                  _updateComponent,
                                  component: component);
                            } else if (component is RadioButtonComponent) {
                              showAddRadioButtonsDialog(context,
                                  _updateComponent,
                                  component: component);
                            } else if (component is DropdownComponent) {
                              showAddDropdownDialog(context,
                                  _updateComponent,
                                  component: component);
                            } else if (component
                            is RatingScaleComponent) {
                              showAddRatingScaleDialog(context,
                                  _updateComponent,
                                  component: component);
                            } else if (component is MatrisComponent) {
                              showAddMatrisDialog(context,
                                  _updateComponent,
                                  component: component);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteComponent(component);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
