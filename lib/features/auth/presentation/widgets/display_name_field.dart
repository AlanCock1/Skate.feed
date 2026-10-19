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

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'El nombre de usuario es obligatorio';
        }
        if (value.length > 100) {
          return 'El nombre de usuario debe ser de 10 dígitos máximo';
        }
        if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$").hasMatch(value.trim())) {
          return 'Solo se permiten letras y espacios';
        }
        return null;
      },

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