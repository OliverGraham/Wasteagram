import 'package:flutter/material.dart';

class WastedFoodForm extends StatefulWidget {
  const WastedFoodForm({Key? key}) : super(key: key);

  @override
  State<WastedFoodForm> createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget itemQuantityField() {
    Locale locale = Localizations.localeOf(context);
    locale.languageCode;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,

        // hintText: Translations(Localizations.localeOf(context).quantityFieldHint)
        decoration: const InputDecoration(hintText: 'Number of wasted items'),
        style: Theme.of(context).textTheme.displayLarge,
        validator: validateItemQuantity,
        onSaved: saveItemQuantity,
      )
    );
  }

  String validateItemQuantity(String? value) {
    return "d";
  }

  void saveItemQuantity(String? value) {
    // go to Firebase?
  }

  Widget uploadButton() {
    return Container();
  }

  void validateSaveUploadAndPop() {
    // huh
  }

  /*String parseDate(DateTime dateTime) {
    return '${DateFormat("EEEE',' MMM'.' d").format(dateTime)}';
  }*/
}
