import 'package:flutter/material.dart';

class WRegistro_Principal {}

class Widget_FormularioText {
  //static Form widget_formularioRegistro({}){

  //}

  static MaterialButton widget_btnRegistrarse(_formKey, context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromARGB(255, 189, 19, 104),
        disabledColor: Colors.grey,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // mensaje emergente: RegistroExitoso
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('¡Registro exitoso!'),
          ));

          Navigator.pushNamed(context, '/');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

        child: Text(
          'Registrarse',
          style: TextStyle(
              fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  static TextFormField widget_txtRegistro(_usernameController) {
    return TextFormField(
      controller: _usernameController,
      decoration: widget_formulariotext(titulo: "Nombre de usuario"),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, ingresa un nombre de usuario';
        }
        return null;
      },
    );
  }

  static TextFormField widget_txtCorreo(_usernameController) {
    return TextFormField(
      controller: _usernameController,
      decoration: widget_formulariotext(titulo: "Correo"),
      validator: (value) {
        //Condicionales / Implementa el servicio de google como correo y como gmail.
        if (value!.isEmpty) {
          return 'Por favor, ingresa una dirección de correo electrónico';
        }
        // Validación básica de formato de correo electrónico
        if (!value.contains('@')) {
          return 'Por favor, ingresa una dirección de correo electrónico válida';
        }
        return null;
      },
    );
  }

  static TextFormField widget_txtContrasena(_usernameController) {
    return TextFormField(
      controller: _usernameController,
      decoration:
          Widget_FormularioText.widget_formulariotext(titulo: "Contraseña"),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, ingresa una contraseña';
        }
        // Puedes agregar más validaciones de seguridad aquí
        return null;
      },
    );
  }

  static InputDecoration widget_formulariotext({
    required String titulo,
  }) {
    return InputDecoration(
        labelText: titulo,
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(color: Color.fromARGB(0, 67, 67, 224), width: 100)));
  }
}
