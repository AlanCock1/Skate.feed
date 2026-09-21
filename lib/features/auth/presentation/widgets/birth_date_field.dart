import 'package:flutter/material.dart';

class BirthDateField extends StatelessWidget {
  const BirthDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha de nacimiento',
        hintText: 'Selecciona tu fecha de nacimiento',
        prefixIcon: Icon(Icons.calendar_today_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),


      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        );
      },
    );
  }
}