import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/form_component.dart';
import '../models/form_model.dart';
import '../services/form_firebase_service.dart';
import '../widgets/edit_tab.dart';
import '../widgets/preview_tab.dart';

class CreateForm extends StatefulWidget {
  final FormModel? form;
  final bool isEditing;

  const CreateForm({Key? key, this.form, this.isEditing = false})
      : super(key: key);

  @override
  _CreateFormState createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController titleController = TextEditingController();
  String formTitle = "Form Başlığı";

  final GlobalKey<EditTabState> editTabKey = GlobalKey<EditTabState>();
  List<FormComponent> components = [];

  final FormFirebaseService firebaseService =
      FormFirebaseService();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    if (widget.isEditing && widget.form != null) {
      formTitle = widget.form!.title;
      components = widget.form!.components;
      titleController.text = formTitle;
    }

    titleController.addListener(() {
      setState(() {
        formTitle = titleController.text;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void updateComponents(List<FormComponent> updatedComponents) {
    setState(() {
      components = updatedComponents;
    });
  }

  void updateFormTitle(String newTitle) {
    setState(() {
      formTitle = newTitle;
    });
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
          title: Text(widget.isEditing ? 'Formu Düzenle' : 'Yeni Form Oluştur'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            controller: tabController,
            labelColor: Color(0xFF65558F),
            unselectedLabelColor: Colors.black,
            indicatorColor: Color(0xFF65558F),
            tabs: [
              Tab(text: 'Düzenle'),
              Tab(text: 'Ön İzle'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            EditTab(
                initialFormTitle: formTitle,
                components: components,
                onComponentsChanged: updateComponents,
                onTitleChanged: updateFormTitle,
                key: editTabKey),
            PreviewTab(
              formTitle: formTitle,
              components: components,
              firebaseService: firebaseService,
              form: widget.form,
            ),
          ],
        ),
      ),
    );
  }
}
