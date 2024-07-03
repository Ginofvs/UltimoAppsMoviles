import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioClasePageState createState() => _HorarioClasePageState();
}

class _HorarioClasePageState extends State<HorarioPage> {
  List<List<String>> horarios = [
    [], // Lunes
    [], // Martes
    [], // Miércoles
    [], // Jueves
    [], // Viernes
    [], // Sábado
    [], // Domingo
  ];

  @override
  void initState() {
    super.initState();
    _cargarHorarios(); // Llama a _cargarHorarios() en initState()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario de Clase'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columnas
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: 7, // Número de días de la semana
        itemBuilder: (BuildContext context, int index) {
          return _buildHorarioItem(context, index);
        },
      ),
    );
  }

  Widget _buildHorarioItem(BuildContext context, int index) {
    List<String> diasSemana = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

    return Card(
      elevation: 3.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diasSemana[index],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Column(
              children: List.generate(horarios[index].length, (idx) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(horarios[index][idx]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          horarios[index].removeAt(idx);
                          _guardarHorarios();
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                _mostrarDialogo(context, index, null);
              },
              child: Text('Añadir Clase'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogo(BuildContext context, int diaIndex, int? claseIndex) {
    String nombreClase = '';
    String horario = '';

    if (claseIndex != null) {
      // Si se está editando una clase existente, prellenar los datos
      nombreClase = horarios[diaIndex][claseIndex].split(' - ')[0];
      horario = horarios[diaIndex][claseIndex].split(' - ')[1];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(claseIndex != null ? 'Editar Clase' : 'Añadir Clase'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nombreClase = value;
                },
                decoration: InputDecoration(
                  labelText: 'Nombre de la Clase',
                ),
                controller: TextEditingController(text: nombreClase),
              ),
              SizedBox(height: 8.0),
              TextField(
                onChanged: (value) {
                  horario = value;
                },
                decoration: InputDecoration(
                  labelText: 'Horario',
                ),
                controller: TextEditingController(text: horario),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (claseIndex != null) {
                    // Si se está editando, actualizar la clase existente
                    horarios[diaIndex][claseIndex] = '$nombreClase - $horario';
                  } else {
                    // Si se está añadiendo, agregar una nueva clase
                    horarios[diaIndex].add('$nombreClase - $horario');
                  }
                  _guardarHorarios();
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _guardarHorarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 7; i++) {
      await prefs.setStringList('horario_$i', horarios[i]);
    }
  }

  void _cargarHorarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() { // Llama a setState() para actualizar el estado
      for (int i = 0; i < 7; i++) {
        List<String>? horarioDia = prefs.getStringList('horario_$i');
        if (horarioDia != null) {
          horarios[i] = horarioDia;
        }
      }
    });
  }
}
