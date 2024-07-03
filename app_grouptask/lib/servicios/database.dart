
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<bool> CrearTarea(String titulo, String descripcion,String Prioridad, String FechaProgramada ) async {
  await Firebase.initializeApp();

  bool Result;

  User? _user = FirebaseAuth.instance.currentUser;
  print(_user.toString());

  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference collectionReference = _db.collection('users');
  try {

    if (titulo == "") {
       titulo = "nuevaTarea";
    }

    await collectionReference.doc(_user!.uid).collection('Tareas').add({
      'Titulo': titulo,
      'Descripcion': descripcion, 
      'Prioridad' : Prioridad,
      'Fecha': FechaProgramada,

    });
    
    return Result = true; 
  } catch (e) {
    print('Error al subir tarea: $e');
  }
  return Result = false;
}



Future<bool> EliminarTarea(String tareaId) async {
  try {
    // Inicialización de Firebase si aún no está inicializado
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    // Obtener el usuario actual
    User? _user = FirebaseAuth.instance.currentUser;
    if (_user == null) {
      print('No hay usuario autenticado.');
      return false;
    }

    // Referencia al documento de la tarea dentro de la colección 'Tareas'
    FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference documentReference = _db.collection('users').doc(_user.uid).collection('Tareas').doc(tareaId);

    // Verificar si el documento existe antes de intentar eliminar
    DocumentSnapshot snapshot = await documentReference.get();
    if (!snapshot.exists) {
      print('La tarea con ID $tareaId no existe.');
      return false;
    }

    // Eliminar la tarea
    await documentReference.delete();

    // La tarea se eliminó correctamente
    return true;
  } catch (e) {
    // Manejar cualquier error
    print('Error al eliminar tarea: $e');
    return false;
  }
}


Future<List> CargarTareas() async {
  await Firebase.initializeApp();

  List getGallery = [[], []];

  User? _user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference collectionReference = _db.collection('users');

  try {
    QuerySnapshot documentSnapshot =
        await collectionReference.doc(_user?.uid).collection("Tareas").get();

    documentSnapshot.docs.forEach((doc) {
      print(doc.id);
      print(doc.data());

      getGallery[0].add(doc.id);
      getGallery[1].add(doc.data());
    });
    return getGallery;
  } catch (e) {
    print(e);
  }
  return getGallery;
}


Stream<List<List<dynamic>>> calendario() async* {
  await Firebase.initializeApp();

  User? _user = FirebaseAuth.instance.currentUser;

  if (_user == null) {
    print("Usuario no autenticado");
    yield [[], []];
    return;
  }

  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference collectionReference = _db.collection('users');

  try {
    // Stream que se suscribe a los cambios en la colección de tareas del usuario autenticado
    Stream<QuerySnapshot> snapshotStream = 
        collectionReference.doc(_user.uid).collection("Tareas").snapshots();

    await for (QuerySnapshot documentSnapshot in snapshotStream) {
      List<List<dynamic>> getGallery = [[], []];

      documentSnapshot.docs.forEach((doc) {
        print(doc.id);
        print(doc.data());

        getGallery[0].add(doc.id);
        getGallery[1].add(doc.data());
      });

      yield getGallery;
    }
  } catch (e) {
    print("Error al cargar tareas: $e");
    yield [[], []];
  }
}




Future<List<List<dynamic>>> CargarTareasAll() async {
  await Firebase.initializeApp(); // Inicializa Firebase si no se ha inicializado

  List<List<dynamic>> getGallery = [[], []]; // Lista para almacenar IDs y datos de tareas

  User? _user = FirebaseAuth.instance.currentUser; // Obtiene el usuario actual

  if (_user == null) {
    throw Exception('Usuario no autenticado');
  }

  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference collectionReference = _db.collection('users');

  try {
    // Consulta la colección 'Tareas' del usuario actual
    QuerySnapshot documentSnapshot = await collectionReference
        .doc(_user.uid)
        .collection("Tareas")
        .get();

    // Itera sobre los documentos obtenidos
    documentSnapshot.docs.forEach((doc) {
      // Imprime el ID y los datos de cada documento (para depuración)
      print(doc.id);
      print(doc.data());

      // Agrega el ID y los datos del documento a getGallery
      getGallery[0].add(doc.id);
      getGallery[1].add(doc.data());
    });

    // Devuelve la lista de IDs y datos de tareas
    return getGallery;
  } catch (e) {
    // Captura cualquier excepción que ocurra durante la consulta
    print("Error al cargar tareas: $e");
    // Puedes manejar el error aquí según sea necesario
    throw Exception('No se pudieron cargar las tareas');
  }
}


Future<bool> ActualizarDescripcionTarea(String tareaId, String nuevaDescripcion) async {
  await Firebase.initializeApp();

  bool result = false;

  User? user = FirebaseAuth.instance.currentUser;
  print(user.toString());

  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference collectionReference = db.collection('users');
  
  try {
    if (nuevaDescripcion.isEmpty) {
      nuevaDescripcion = "Sin descripción";
    }

    await collectionReference
        .doc(user!.uid)
        .collection('Tareas')
        .doc(tareaId)
        .update({'Descripcion': nuevaDescripcion});
    
    result = true;
  } catch (e) {
    print('Error al actualizar descripción de la tarea: $e');
  }
  
  return result;
}








//
// Ver este tema d  firebase

// class DatabaseMethods{
//   Future addTodayWork(Map<String,dynamic> userTodayMap, String id)async{
//     return await Firebase
//   }
// }