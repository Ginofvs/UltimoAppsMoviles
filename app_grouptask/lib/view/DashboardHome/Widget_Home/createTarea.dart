import 'dart:async';

import 'package:app_grouptask/servicios/database.dart';
import 'package:app_grouptask/view/DashboardHome/Widget_Home/WidgetTask/TaskSelect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class createTarea extends StatefulWidget {
  @override
  _CreateTareaState createState() => _CreateTareaState();
}

class _CreateTareaState extends State<createTarea> {
  late List<dynamic> tareas = [[],[]];

  TextEditingController _controllerTitulo = TextEditingController();

  TextEditingController _controllerDescripcion = TextEditingController();
  String _activatorConsole= "";

  bool _isCheckedPrioridadGreen = false;
  bool _isCheckedPrioridadYellow = false;
  bool _isCheckedPrioridadRed = false;

  
  @override
  void initState() {
    super.initState();
    _ObtenerTareas();
    //_cargarTareas();
    
  }
  Future<void> _ObtenerTareas() async{
      List<dynamic> cargaLista = [[],[]];
      cargaLista =  await CargarTareas();
      setState(() {
        tareas = cargaLista;
      });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List',style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.amber
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //titulo
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Color de fondo del contenedor
                        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del contenedor
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Color de la sombra con opacidad
                            spreadRadius: 3, // Radio de difusión de la sombra
                            blurRadius: 5, // Radio de desenfoque de la sombra
                            offset: Offset(0, 3), // Desplazamiento de la sombra, en este caso, hacia abajo
                          ),
                        ],
                      ),
                    child: Column(
                      children: [



                        TextField(
                          controller: _controllerTitulo,
                          decoration: InputDecoration(
                            labelText: 'Titulo de la Tarea',
                              border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del campo
                              borderSide: BorderSide(color: Colors.grey, width: 1.0), // Color y ancho del borde
                            ),
                        
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding interno del campo de texto
                            hintText: 'Ingrese el título', // Texto de sugerencia cuando el campo está vacío
                            hintStyle: TextStyle(color: Colors.grey), // Estilo del texto de sugerencia
                            prefixIcon: Icon(Icons.title), // Icono antes del texto del campo
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear), // Icono para borrar el contenido del campo
                              onPressed: () => _controllerTitulo.clear(), // Función para borrar el contenido
                            ),
                          ),
                        ),

                  SizedBox(height: 10),
                  //Descripcion
                  Container(
                      decoration: BoxDecoration(
                  color: Colors.grey[200], // Color de fondo del contenedor
                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del contenedor
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Color de la sombra con opacidad
                      spreadRadius: 3, // Radio de difusión de la sombra
                      blurRadius: 5, // Radio de desenfoque de la sombra
                      offset: Offset(0, 3), // Desplazamiento de la sombra, en este caso, hacia abajo
                    ),
                  ],
                ),
                    child: TextField(
                      controller: _controllerDescripcion,
                      decoration: InputDecoration(
                        labelText: 'Descripción de la Tarea',
                        border:  UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del campo
                              borderSide: BorderSide(color: Colors.grey, width: 1.0), // Color y ancho del borde
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding interno del campo de texto
                            hintText: 'Ingrese descripcion', // Texto de sugerencia cuando el campo está vacío
                            hintStyle: TextStyle(color: Colors.grey), // Estilo del texto de sugerencia
                            prefixIcon: Icon(Icons.description), // Icono antes del texto del campo
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear), // Icono para borrar el contenido del campo
                              onPressed: () => _controllerDescripcion.clear(), // Función para borrar el contenido
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                      
                      
          
                  PrioridadOpcion(),
                  FechaProgramada(),
                  GuardarTarea(),          
                  SizedBox(height: 20),







                      ],
                    ),
                  ),
                      
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: tareas[1].length,
                      itemBuilder: (context, index) {
                      
                        Color  color_change = Colors.white; 
                        if (tareas[1][index]['Prioridad'] == "verde") {
                          color_change = Colors.green;
                        } if (tareas[1][index]['Prioridad'] == "amarillo") {
                          color_change = Colors.yellow;

                        } if (tareas[1][index]['Prioridad'] == "rojo") {
                          color_change = Colors.red;
                        }


                        return ListTile(
                          title: Container(
                            
                            child: GestureDetector(
                              onTap: ()   {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskSelect(id:tareas[0][index].toString(), Titulo:tareas[1][index]['Titulo'].toString(),Descripcion:tareas[1][index]['Descripcion'].toString())));
                                },
                              child: Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del contenedor
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5), // Color de la sombra con opacidad
                                      spreadRadius: 3, // Radio de difusión de la sombra
                                      blurRadius: 5, // Radio de desenfoque de la sombra
                                      offset: Offset(0, 3), // Desplazamiento de la sombra, en este caso, hacia abajo
                                    ),
                                  ],
                                ),
                                                    
                                                    
                                child: Row(
                                  children:<Widget> [
                                        Icon(
                                            Icons.square, // Icono que deseas mostrar, por ejemplo, un check
                                            color: color_change, // Color del icono
                                            size: 30, // Tamaño del icono
                                          ),                                  Column(
                                      children: [
                                        Text(tareas[1][index]['Titulo'].toString()),
                                        //Text(tareas[1][index]['Descripcion'].toString()),
                                            
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(5),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: ()  async{
                              bool  result = await EliminarTarea(tareas[0][index].toString());
                              if (result) {
                                
                              setState(() {
                                //_guardarTareas();
                                 _ObtenerTareas();
                                });  
                              }
                              
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget GuardarTarea(){
    return                    ElevatedButton(
                    onPressed: () async {
                      String _fechaSelecionada='${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';

                       if (_isCheckedPrioridadGreen) {
                              _activatorConsole = "verde";
                              print("es verde");
                            } if (_isCheckedPrioridadYellow) {
                              _activatorConsole = "amarillo";

                              print("es amarillo");
                            } if (_isCheckedPrioridadRed) {
                              _activatorConsole = "rojo";
       
                              print("es rojo");
                            }
                                            
                      bool result = await CrearTarea(_controllerTitulo.text, _controllerDescripcion.text,_activatorConsole,_fechaSelecionada);
                      if (result){
                        tareas =  await CargarTareas();
                      
                      setState(()  {
                           

                            //tareas.add(_controllerDescripcion.text);
                            _controllerTitulo.clear();
                            _controllerDescripcion.clear();
                            _selectedDate = null;
                            _isCheckedPrioridadGreen = false;
                            _isCheckedPrioridadYellow = false;
                            _isCheckedPrioridadRed = false;
                            //_guardarTareas();
                          //_cargarTareas();
                            _ObtenerTareas;
                        });
                      }
                    },
                    child: Text('Guardar Tarea'),
                  );
  }


  Widget PrioridadOpcion(){
    return  Container(
      padding: EdgeInsets.all(1),
      child: Row(
                        children: [
                          Row(
                            children: [
      
                              Column(
                                children: [
                                  Checkbox(
                                    
                                    value: _isCheckedPrioridadGreen,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isCheckedPrioridadGreen = value!;
                                      });
                                    
                                    },
                                    
                                    activeColor: Colors.green, // Color cuando el checkbox está activo
                                    checkColor: Colors.white, // Color del check dentro del checkbox
                                  ),
                                ],
                              ),
                              Text("Importante"),
                            ],
                          ),
                
                           Row(
                            children: [
      
                              Column(
                                children: [
                                  Checkbox(
                                    
                                    value: _isCheckedPrioridadYellow,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isCheckedPrioridadYellow = value!;
                                      });
                                    
                                    },
                                    
                                    activeColor: Colors.yellow, // Color cuando el checkbox está activo
                                    checkColor: Colors.white, // Color del check dentro del checkbox
                                  ),
                                ],
                              ),
                              Text("Regular"),
                            ],
                          ),
                                  
                           Row(
                            children: [
      
                              Column(
                                children: [
                                  Checkbox(
                                    
                                    value: _isCheckedPrioridadRed,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isCheckedPrioridadRed = value!;
                                      });
                                    
                                    },
                                    
                                    activeColor: Colors.red, // Color cuando el checkbox está activo
                                    checkColor: Colors.white, // Color del check dentro del checkbox
                                  ),
                                ],
                              ),
                              Text("Desprocu"),
                            ],
                          ),
                        ],
                      ),
    );

  }
  
  
   Widget FechaProgramada(){
  return TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate == null
                    ? 'Seleccionar Fecha'
                    : 'Fecha seleccionada: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
            );
    
            }
  
    DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }



}
