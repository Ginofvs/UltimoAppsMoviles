
import 'package:app_grouptask/servicios/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskSelect extends StatelessWidget {
  //final List<dynamic> tareas ;
  //final int index;
  final String id;
  final String Titulo;
  final String Descripcion;
  const TaskSelect({required this.id, required this.Titulo,required this.Descripcion, super.key});

  @override
  Widget build(BuildContext context) {

  TextEditingController _controllerDescripcion = TextEditingController(text: Descripcion + '\n' * 20,);
    
    return Scaffold(
      backgroundColor: Colors.amber,
      body: 
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
              padding: EdgeInsets.all(20),
           
             decoration: BoxDecoration(color:Colors.white),
             child: SingleChildScrollView(
               child: Center(
                 child: Column(
                   children: <Widget>[
                     Text(Titulo),
                          
                     TextField(
                      controller: _controllerDescripcion,
                        maxLines: null,
                        decoration: InputDecoration(
                        
                          labelText: 'Descripción de la Tarea',
                          border: OutlineInputBorder(),
                           
                        ),
                      ),                         
                      ElevatedButton(onPressed: () async {
                        if (await ActualizarDescripcionTarea(id, _controllerDescripcion.text)) {
                          Navigator.pop(context);
                          _controllerDescripcion.clear();
                        }
                        
                      }, child: Text("Guardar Cambios")),
                   ]
                   
                 ),
               ),
             ),
           ),
         ),
      
      
    );
  }
}