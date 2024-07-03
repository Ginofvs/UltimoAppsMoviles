import 'package:app_grouptask/Provider/GoogleSignIn.dart';
import 'package:app_grouptask/view/AccountHome/AccountHome.dart';
import 'package:app_grouptask/view/DashboardHome/DashboardHome.dart';
import 'package:flutter/material.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  
  int _currentIndex = 0;
  List<Widget> bodyHome = const [
    DashboardHome(),
    AccountHome(),
  ];


  List<String> tittleAppbar =  [
    "Gestor de tareas",
    "Cuenta",
  ];
  
  @override
  void dispose() {
    // TODO: implement dispose
      //GoogleSignInProvider().logout();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                surfaceTintColor: Colors.black,
                title: Center(child: Text(tittleAppbar[_currentIndex],style: TextStyle(fontFamily: "serif",fontWeight: FontWeight.w500),)),

      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newindex) {
          setState(() {
            _currentIndex = newindex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),

          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Center(child: bodyHome[_currentIndex]),
    );



  }
}

