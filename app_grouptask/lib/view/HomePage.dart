import 'package:app_grouptask/view/AppbarHome.dart';
import 'package:app_grouptask/view/IntefacesAuth/Interfaces_Login1.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  Future<Stream> getIntanceFirebaseAuth() async {
    await Firebase.initializeApp();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return firebaseAuth.authStateChanges();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(
      future: getIntanceFirebaseAuth(),
      builder:(context, snapshot){

        return StreamBuilder(
          stream: snapshot.data, 
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            
          } else if(snapshot.hasData){
            return AppBarHome();
        
          } else if(snapshot.hasError){
              return Center(child: Text('Something went wrong!!'));
          } else{
            return Login1();
          }
      
      
      },);
      }
    ) ,
  );
}