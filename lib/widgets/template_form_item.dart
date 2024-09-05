import 'package:flutter/material.dart';
import '../models/template_form_model.dart';
import '../managers/form_manager.dart';

Widget buildTemplateFormItem(BuildContext context, TemplateFormModel form,
    FormManager<TemplateFormModel> manager) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/ic_list-item.png', height: 50),
              IconButton(
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
            ],
          ),
          const SizedBox(height: 24),
          Text(
            form.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    ),
  );
}
