import 'package:flutter/material.dart';

class DisplayNameField extends StatelessWidget {
  const DisplayNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre de usuario',
        hintText: 'Ingresa el nombre que quieres que los demás vean',
        prefixIcon: Icon(Icons.person_outline),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}