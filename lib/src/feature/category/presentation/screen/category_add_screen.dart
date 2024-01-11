import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// add catgeory screen
// name, description, image

class CategoryAddScreen extends StatelessWidget {
  CategoryAddScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'description',
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: FormBuilderValidators.compose([]),
                ),
                FormBuilderField<File>(
                  builder: (FormFieldState<File> field) {
                    return Column(
                      children: [
                        Text('Image'),
                        ElevatedButton(
                          onPressed: () async {
                            /*final result = await context
                                    .read<AuthProvider>()
                                    .pickImage();*/
                            /*if (result != null) {
                                  field.didChange(result);
                                }*/
                          },
                          child: Text('Pick Image'),
                        ),
                        if (field.value != null)
                          Image.file(
                            field.value!,
                            height: 200,
                            width: 200,
                          ),
                      ],
                    );
                  },
                  name: 'image',
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                print(_formKey.currentState!.value);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
