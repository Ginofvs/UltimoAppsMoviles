import 'package:flutter/material.dart';

class IconoPersona extends StatelessWidget {
  const IconoPersona({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}