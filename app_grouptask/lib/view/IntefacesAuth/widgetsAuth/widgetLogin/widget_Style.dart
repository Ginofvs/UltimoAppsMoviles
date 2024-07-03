import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration({
    required String hintText,
    required String labelText,
    required Icon icono,
  }) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 128, 128),width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 224, 6, 6), width: 2)),
        hintText: hintText,
        labelText: labelText,
        prefixIcon: icono);
  }
}

class ButtonMaterial {
  final String tittle;
  final TextEditingController controllerGmail;
  final TextEditingController controllerPassword;
  final BuildContext context;

  const ButtonMaterial(
      {required this.tittle, required this.controllerGmail, required this.controllerPassword,required this.context});

  MaterialButton materialButton() {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromARGB(255, 189, 19, 104),
        disabledColor: Colors.grey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Text(
            tittle,
            style: TextStyle(
                color: Colors.white,
                fontFamily: "serif",
                fontWeight: FontWeight.w300),
          ),
        ),
        onPressed: PushLooged);
  }

  //Funcion de Logeado
  void PushLooged() {
    //un Map para guardar datos de usuario
    Map usuarioAdminstrador= {"Usuario":"admin","Correo":"@admin","Contraseña":"admin"};
    if (controllerGmail.text.toString() == usuarioAdminstrador["Correo"] && controllerPassword.text.toString() == usuarioAdminstrador["Contraseña"]) {
      print("Inicio de Sesion");
      Navigator.pushNamed(context, "/HomePage");
    } else {
      print("registrado");
    }
  }
  // String Text
}
