
import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetLogin/widget_CajaTop.dart';
import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetLogin/widget_Form.dart';
import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetLogin/widget_IconPerson.dart';
import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetLogin/widget_OtherPlataforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class Login1 extends StatefulWidget {
  const Login1({super.key});

  @override
  State<Login1> createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  Color _backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: _backgroundColor,
          child: Stack(

            //Capas 
            children: [
              //Metodo Stack: permite compilar en capas cada uno de los widgets
              LoginWithOtherPlataforms(),
              CajaTop(Size: Size),
              IconoPersona(),
              LoginForm(Size:Size)
            ],
          )),
    );
  }
}
