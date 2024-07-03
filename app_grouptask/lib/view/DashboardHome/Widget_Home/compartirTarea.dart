import 'package:app_grouptask/servicios/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart'; // Importa el paquete Share para compartir contenido

class compartirTarea extends StatefulWidget {
  @override
  _VisualizarTareasState createState() => _VisualizarTareasState();
}

class _VisualizarTareasState extends State<compartirTarea> {
  List<dynamic> tareas= [];

  @override
  void initState() {
    super.initState();
    _ObtenerTareas;
    //_cargarTareas();
  }

  Future<void> _ObtenerTareas() async {
    try {
      List<List<dynamic>> cargaLista = await CargarTareasAll();
      setState(() {
        tareas = cargaLista[1]; // Asigna solo los datos de las tareas a 'tareas'
      });
    } catch (e) {
      print('Error al obtener tareas: $e');
      // Manejar el error según sea necesario
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Tareas'),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tareas[index].toString()),
            trailing: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                //_compartirTarea(tareas[index]);
              },
            ),
          );
        },
      ),
    );
  }

  void _compartirTarea(String tarea) {
    Share.share('Tarea: $tarea'); // Comparte la tarea utilizando el paquete Share
  }
}
