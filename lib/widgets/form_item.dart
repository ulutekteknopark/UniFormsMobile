import 'package:flutter/material.dart';
import '../models/form_model.dart';
import '../managers/form_manager.dart';
import 'form_menu_card.dart';

Widget buildFormItem(
    BuildContext context, FormModel form, FormManager<FormModel> manager) {
  return Card(
    color: Colors.white,
    child: ListTile(
      leading: Image.asset('assets/icons/ic_list-item.png'),
      title: Text(form.title),
      subtitle: Text(''),
      trailing: IconButton(
        icon: Icon(
          form.isStarred ? Icons.star : Icons.star_border,
          color: form.isStarred ? Colors.yellow : Colors.black,
        ),
        onPressed: () {
          form.isStarred = !form.isStarred;
          if (form.isStarred) {
            manager.starredForms.add(form);
          } else {
            manager.starredForms.remove(form);
          }
          manager.applyFilter();
        },
      ),
      onTap: () {
        MenuCardWidget.showMenuCard(context, form);
      },
    ),
  );
}
