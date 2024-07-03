import 'package:app_grouptask/Provider/GoogleSignIn.dart';
import 'package:app_grouptask/view/DashboardHome/Widget_Home/PersonalizationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AccountHome extends StatefulWidget {
  const AccountHome({super.key});

  @override
  State<AccountHome> createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  final List<String> nombreopciones = [
    'Personalizar',
    'Salir',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AccountCurrent(context),
          Expanded(child: AccountOptions())
        ],
      ),
    );
  }
  Widget AccountOptions(){

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
      child: GridView.builder(
        itemCount: nombreopciones.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,crossAxisSpacing: 20,), 
        itemBuilder: (context, index) {
            return  BtnFuncionHome(index: index, onPressed: buttonActions(context)[index] ?? () {});
      },));
  }

  Widget BtnFuncionHome({required int index, required VoidCallback onPressed}){

    return ElevatedButton(
                        onPressed:  onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromRGBO(159, 205, 243, 1), // Color del botón
                          minimumSize: Size(100, 100), // Tamaño mínimo del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                          ),
                             elevation: 5, // Elevación para la sombra del botón
                              padding: EdgeInsets.all(16.0), // Padding interno del botón
                        ),
                        child: Text(nombreopciones[index]),
                      );
  }


  Map<int, VoidCallback> buttonActions(BuildContext context) {
    return {
      0: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonalizationPage(),
          ),
        );
      },
      1: () {
        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.logout();
      },
    };
  }


  Widget AccountCurrent(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(30.0),
      
        decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 95, 84), // Color de fondo rojo
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3), // Color de sombra
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // Desplazamiento de la sombra
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10), // Bordes redondeados
                      ),
        child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user!.photoURL!),
            ),
                          Text("Nombre_Usuario: ${user.displayName ?? 'Nombre no obtenido'}", style: TextStyle(color: Colors.white)),
                          Text("Correo: ${user.email ?? 'Correo no obtenido'}", style: TextStyle(color: Colors.white)),
      
          ],
        ),
      ),
    );
  }
}
