import 'package:flutter/material.dart';

class DisplayNameField extends StatelessWidget {
  
  final TextEditingController controller;

  const DisplayNameField({
    super.key,
    required this.controller
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

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