import 'package:app_grouptask/Provider/GoogleSignIn.dart';
import 'package:app_grouptask/servicios/database.dart';
import 'package:app_grouptask/view/DashboardHome/Widget_Home/HorarioPage.dart';
import 'package:app_grouptask/view/DashboardHome/Widget_Home/compartirTarea.dart';
import 'package:app_grouptask/view/DashboardHome/Widget_Home/createTarea.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  late List<dynamic> actividades = [[],[]];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isCalendarVisible = false;
  DateTime? _timeData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _actualizarTarea;
  }

  Future<void> _actualizarTarea() async{
      List<dynamic> cargaLista = [[],[]];
      cargaLista =  await CargarTareas();
      setState(() {
        actividades = cargaLista;
      });
  }


  @override
  Widget build(BuildContext context) {
    String descripcion="";
    final user = FirebaseAuth.instance.currentUser!;

    
    print(actividades);
    return  Scaffold(
      backgroundColor: Colors.amber,
      
      body: GestureDetector(
        onTap: () {
          setState(() {
          _isCalendarVisible = false;
            
          });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.amberAccent),
          child: Center(
              child: Column(
                children: [
                  Container(
                    child: Card(
                      child: _isCalendarVisible  
                        ? FutureBuilder(
                          future: CargarTareas(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return TableCalendar(
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            onFormatChanged: (format) {
                            setState(() {
                                _calendarFormat = format;
                            });
                            },
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay; // update `_focusedDay` as well
                             //_isCalendarVisible = false; // Hide the calendar when a day is selected
                          
                            });
        
                             String? descripcion = _getTaskDescriptionForDay(selectedDay,snapshot);
        
                            if (descripcion != null) {
                                  _showDayInfo(context, selectedDay,descripcion);
                              
                            } else {
                              _showNoTaskInfo(context, selectedDay);
                            }
        
        
                            },
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                          
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              formatButtonVisible: false,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                              )
                            ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                decoration: BoxDecoration(
                                  
                                  color: Colors.blue,
                                  border: Border.symmetric(vertical: BorderSide(color: Colors.black,width: 2))
                                ),
                              
                              weekdayStyle: TextStyle(color: Colors.white,),
                              weekendStyle: TextStyle(color: Colors.red),
                            ),
                            calendarBuilders:CalendarBuilders(
        
                              todayBuilder: (context, date, _) {
                                return Container(
                                    margin: const EdgeInsets.all(6.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                );
                              },
                              selectedBuilder: (context, date, _) {
                          
                                
                                  return Container(
                                margin: const EdgeInsets.all(6.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                               );
                              },
                              defaultBuilder: (context, date, _) {
                                
                                               bool hasTaskRed = snapshot.data![1].any((t) {
                                              List<String> parts = t['Fecha'].toString().split('/');
                                              int day = int.parse(parts[0]);
                                              int month = int.parse(parts[1]);
                                              int year = int.parse(parts[2]);
                                              DateTime taskDate = DateTime(year, month, day);
                                              return date.year == taskDate.year &&
                                                    date.month == taskDate.month &&
                                                    date.day == taskDate.day && t['Prioridad'] == "rojo";
                                               });
        
                                              bool hasTaskYellow = snapshot.data![1].any((t) {
                                              List<String> parts = t['Fecha'].toString().split('/');
                                              int day = int.parse(parts[0]);
                                              int month = int.parse(parts[1]);
                                              int year = int.parse(parts[2]);
                                              DateTime taskDate = DateTime(year, month, day);
                                              return date.year == taskDate.year &&
                                                    date.month == taskDate.month &&
                                                    date.day == taskDate.day && t['Prioridad'] == "amarillo";
                                               });
        
                                              bool hasTaskGreen = snapshot.data![1].any((t) {
                                              List<String> parts = t['Fecha'].toString().split('/');
                                              int day = int.parse(parts[0]);
                                              int month = int.parse(parts[1]);
                                              int year = int.parse(parts[2]);
                                              DateTime taskDate = DateTime(year, month, day);
                                              return date.year == taskDate.year &&
                                                    date.month == taskDate.month &&
                                                    date.day == taskDate.day && t['Prioridad'] == "verde";
                                               });
        
                                  //print(snapshot.data![1].length.toString());
                                  //print(task['Fecha'].toString());
                                    // Divide la cadena en partes usando el separador '/'
                                    //List<String> parts = snapshot.data![1]['Fecha'].toString().split('/');
        
                                    // Convierte las partes en enteros
                                    //int day = int.parse(parts[0]);
                                    //int month = int.parse(parts[1]);
                                    //int year = int.parse(parts[2]);
        
                                    // Crea un objeto DateTime usando los valores de año, mes y día
                                    //DateTime newDate = DateTime(year, month, day);
        
                          return Container(
                                              margin: const EdgeInsets.all(6.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: hasTaskGreen  
                                                    ? Colors.green
                                                    : hasTaskYellow 
                                                    ? Colors.yellow 
                                                    : hasTaskRed
                                                    ? Colors.red : date.weekday == DateTime.sunday
                                                        ? Colors.red.withOpacity(0.5)
                                                        : Colors.grey.withOpacity(0.5),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            );
        
                              }
                          
                          
                          
                          
                            
                              
                            ),
                          
                                              );
                            } else if (snapshot.hasError) {
                              return Container();
                            }
                            return Container();
                            
        
                          },
                           
                        ) :  Center(
                        child: ElevatedButton(
                          onPressed: _showCalendar,
                          child: Text('Mostrar Calendario'),
                        ),
                      ),
                      
                    ),
                  ),
        
        
                  Expanded(
                    child: Container(
                      alignment: Alignment.center, // Centra los elementos hijos
                      child: GridView.count(
                        crossAxisCount: 2, // 2 columnas en la cuadrícula
                        mainAxisSpacing: 20.0, // Espacio vertical entre los elementos
                        crossAxisSpacing: 20.0, // Espacio horizontal entre los elementos
                        padding:
                            EdgeInsets.all(20.0), // Espaciado alrededor de la cuadrícula
                        children: [
                      
                      
                      
                      
                      
                          //crear tarea:
                      
                          ElevatedButton(
                            onPressed: () {
                              // Navegar a la página de creación de tarea
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => createTarea()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(159, 205, 243, 1), // Color del botón
          
                              minimumSize: Size(120, 120), // Tamaño mínimo del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                              ),
          
                                  elevation: 5, // Elevación para la sombra del botón
                                  padding: EdgeInsets.all(16.0), // Padding interno del botón
                            ),
                            child: Text('Crear Tarea'),
                          ),
                                            
                      
                          //crear Horariopage:
                          ElevatedButton(
                            onPressed: () {
                              // Navegar a la página de horarios de clase
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HorarioPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(159, 205, 243, 1), // Color del botón
                              minimumSize: Size(120, 120), // Tamaño mínimo del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                              ),
          
                                 elevation: 5, // Elevación para la sombra del botón
                                  padding: EdgeInsets.all(16.0), // Padding interno del botón
                            ),
                            child: Text('Ver Horarios de Clase'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navegar a la página de horarios de clase
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => compartirTarea()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromRGBO(159, 205, 243, 1), // Color del botón
                              minimumSize: Size(120, 120), // Tamaño mínimo del botón
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Bordes cuadrados
                              ),
                                 elevation: 5, // Elevación para la sombra del botón
                                  padding: EdgeInsets.all(16.0), // Padding interno del botón
                            ),
                            
                            child: Text('Compartir Tareas'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }

  void _showCalendar() {
    
    setState(() {
      _isCalendarVisible = true;
    });
  }

  void _showDayInfo(BuildContext context, DateTime day,String Descripcion) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Información del día',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Fecha: ${day.day}/${day.month}/${day.year}',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              
              Text(
                getShortDescription(Descripcion),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isCalendarVisible = true; // Show the calendar when the modal is dismissed
      });
    });

  }

  String getShortDescription(String description) {
    if (description.length > 15) {
      return '${description.substring(0, 20)}...';
    } else {
      return description;
    }
  }

  String? _getTaskDescriptionForDay(DateTime selectedDay,AsyncSnapshot snapshot) {
    for (var task in snapshot.data![1]) {
      List<String> parts = task['Fecha'].toString().split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);
      DateTime taskDate = DateTime(year, month, day);
      if (selectedDay.year == taskDate.year &&
          selectedDay.month == taskDate.month &&
          selectedDay.day == taskDate.day) {
        return task['Descripcion'];
      }
    }
    return null;
  }

  void _showNoTaskInfo(BuildContext context, DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información del día'),
          content: Text('No hay tareas para este día.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }



  ElevatedButton ButtonLogout(){
    return  ElevatedButton(
      child: Text("Salir"),
      onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
  });

}

}

