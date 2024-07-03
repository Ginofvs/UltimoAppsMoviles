
import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetRegister/Widget_Registro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Registro1 extends StatefulWidget {
  const Registro1({super.key});

  @override
  State<Registro1> createState() => _Registro1State();
}

class _Registro1State extends State<Registro1> {


  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    //Registro scaffold
    return Scaffold(
        
    backgroundColor: Colors.amber,
      body:   Stack(
        children: [
SingleChildScrollView(
  child: Container(       
            child: Padding(
              padding: EdgeInsets.all(10.0),
              //contenedor base
              child: Column(
                children: [
                  SizedBox(height: 200,),
                  Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: Size.width,
                      height: Size.height * 0.5,
                    decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                offset: Offset(10, 5))
                          ]),
                              
                    //Titulo Registro contenedor
                              
                              
                    child: Column(
                      
                      children: [
                        Container(
                        child: Text("Registro",style: TextStyle(fontSize: 30,color:Colors.black,fontFamily: "Serif"),),
                              
                        ),
                              
                    //Formulario Registro(NombreUsuario,Correo,Contraseña);
                        Form(
                          key: _formKey,
                          child: Column(

                        
                            children: <Widget>[
                        
                              //Texfield_NombreUsuario: Controlador
                        
                              Widget_FormularioText.widget_txtRegistro(_usernameController),
                        
                              //Texfield_Email: Controlador
                        
                              Widget_FormularioText.widget_txtCorreo(_emailController),
                        
                              //Texfield_Email: Controlador
                        
                              Widget_FormularioText.widget_txtContrasena(_passwordController),
                            
                              SizedBox(height: 25,),
                              // ElevateButton_RegistroExitoso: Push
                              Container(
                                  child: Widget_FormularioText.widget_btnRegistrarse(_formKey, context),
                                
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
),
 
        ]
        
             ),
    );
  }
}