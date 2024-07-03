import 'package:flutter/material.dart';

class CajaTop extends StatelessWidget {
  const CajaTop({
    super.key,
    required this.Size,
  });

  final dynamic Size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 176, 1)
      ])),
      width: double.infinity,
      height: Size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: Burbuja(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: Burbuja(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: Burbuja(),
            top: -50,
            left: -20,
          ),
          Positioned(
            child: Burbuja(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: Burbuja(),
            bottom: 120,
            right: 20,
          )
        ],
      ),
    );
  }

  Widget Burbuja(){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}