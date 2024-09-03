import 'package:flutter/material.dart';
import '../models/base_form_model.dart';

class FormManager<T extends BaseFormModel> {
  final TextEditingController searchController = TextEditingController();
  List<T> allForms = [];
  List<T> filteredForms = [];
  List<T> starredForms = [];
  bool isStarred = false;

  // Callback to notify UI updates
  final VoidCallback onUpdate;

  FormManager({required this.onUpdate});

  void filterForms(String searchText) {
    if (searchText.isEmpty) {
      applyFilter();
    } else {
      filteredForms = (isStarred ? starredForms : allForms)
          .where((form) =>
              form.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    onUpdate(); // Notify UI
  }

  void applyFilter() {
    if (isStarred) {
      filteredForms = starredForms;
    } else {
      filteredForms = allForms;
    }
    onUpdate(); // Notify UI
  }

  void sortAlphabetically() {
    filteredForms.sort((a, b) => a.title.compareTo(b.title));
    onUpdate(); // Notify UI
  }

  void sortByDate() {
    filteredForms.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    onUpdate(); // Notify UI
  }
}
