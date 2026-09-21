import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});   // Este Constructor significa: "permítele a Flutter recibir y pasarle una Key a este widget si alguna vez la necesita."

  @override
  Widget build(BuildContext context) {
    return TextFormField(  // TextFormField es básicamente uno de los componentes de Flutter para introducir texto dentro de formularios.
      keyboardType: TextInputType.emailAddress, //Esta línea indica: "Este campo espera una dirección de correo electrónico.". De hecho también afecta al teclado de los móviles para que aparezca @ y . 
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Ingresa tu correo',
        prefixIcon: Icon(Icons.email_outlined),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}