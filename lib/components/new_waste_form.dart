import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewWasteForm extends StatefulWidget {

  const NewWasteForm({Key? key}) : super(key: key);
  static int _numberOfWastedItems = -1;

  static int getNumberOfWastedItems() {
    return _numberOfWastedItems;
  }

  static bool isFormValid() {
    return _NewWasteFormState._formKey.currentState!.validate();
  }

  static void saveForm() {
    _NewWasteFormState._formKey.currentState!.save();
  }

  @override
  State<NewWasteForm> createState() => _NewWasteFormState();
}

class _NewWasteFormState extends State<NewWasteForm> {

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: TextFormField(
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters:  <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration:
            const InputDecoration(hintText: 'Number of wasted items'),
          validator: _validateNumber,
          onSaved: _savedNumberOfWastedItems
        )
    );
  }

 static void _savedNumberOfWastedItems(dynamic amount) {
    NewWasteForm._numberOfWastedItems = int.parse(amount);
  }

  static String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the number of wasted items';
    }
    return null;
  }
}
