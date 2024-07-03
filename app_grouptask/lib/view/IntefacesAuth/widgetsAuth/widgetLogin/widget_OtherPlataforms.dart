import 'package:flutter/material.dart';
import 'package:app_grouptask/Provider/GoogleSignIn.dart';
// import 'package:app_grouptask/pages/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginWithOtherPlataforms extends StatelessWidget {
  const LoginWithOtherPlataforms({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
                    SizedBox(
              height: 690,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Inicia Sesion con: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "serif",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: const Color.fromARGB(255, 85, 84, 84)),
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {

         // GoogleSignInAccount? _user;

         // if (_user != null && _user.id.isNotEmpty) {
          //  Navigator.push(
           //     context,
            //    MaterialPageRoute(
             //     builder: (context) => Home(),
              //  ));
         // } else {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googlelogin();
          //}
        



                      },
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                      //FaIcon(FontAwesomeIcons.google, color: Colors.red)
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: const Color.fromARGB(255, 85, 84, 84)),
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Icon(Icons.cancel_outlined),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: const Color.fromARGB(255, 85, 84, 84)),
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Icon(Icons.cancel_outlined),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: const Color.fromARGB(255, 85, 84, 84)),
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ],
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}