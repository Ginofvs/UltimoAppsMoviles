import 'package:app_grouptask/view/IntefacesAuth/widgetsAuth/widgetLogin/widget_Style.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.Size
  });

  final dynamic Size;

  @override
  Widget build(BuildContext context) {
    

    
    double final_height = 32.0;
    TextEditingController _TextFormFieldGmail = TextEditingController();
    TextEditingController _TextFormFieldPassword = TextEditingController();
   
   
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250 ,
          ),
          
          //Contenedor principal / 
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: Size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(10, 5))
                ]),
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'Inicio',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 30,
                ),

                //Contenedor Formulario.
                Container(
                  child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          //TextField_Correo Electronico = controller
                          TextFormField(
                            controller: _TextFormFieldGmail,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecorations.inputDecoration(
                                hintText: 'ejemplo@gmail.com',
                                labelText: 'Correo electronico',
                                icono: Icon(Icons.alternate_email_rounded)),
                            validator: (value) {
                              String pattern =
                              "@";
                                  //r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regexp = new RegExp(pattern);
                              return regexp.hasMatch(value ?? '')
                                  ? null
                                  : 'El valor ingresado no es un correo';
                            },
                          ),
                          //TextField_Contraseña = controller

                          TextFormField(
                            controller: _TextFormFieldPassword,
                            autocorrect: false,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '***********',
                                labelText: 'Contraseña',
                                icono: Icon(Icons.alternate_email_rounded)),
                            validator: (value) {
                              return (value != null && value.length >= 6)
                                  ? null
                                  : "la contraseña debe de ser mayor o igual a 6 caracteres";
                            },
                          ),                          
                          SizedBox(height: final_height),
                          //Button_IniciarSesion
                          ButtonMaterial(
                            
                            tittle: "Iniciar Sesion",
                            controllerGmail: _TextFormFieldGmail,
                            controllerPassword: _TextFormFieldPassword,
                            context: context,
                          ).materialButton(),
                        ],
                      )),
                ),

                //Opcion_Registrarse/
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0),
                    child: Container(
                      alignment: AlignmentDirectional.center,
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Texto No tienes cuenta"
                        Text("No tienes cuenta?"),
                        SizedBox(
                          width: 5,
                        ),
                  
                        //Opcion_Registrarse
                        GestureDetector(
                          child: Container(
                            child: const Text(
                              "Registrarte.",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 98, 156, 255)),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/Registro1");
                          },
                        ),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}