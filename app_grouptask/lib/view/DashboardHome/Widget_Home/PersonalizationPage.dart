import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_grouptask/main.dart';

class PersonalizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalización'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                ThemeData newTheme =
                    value ? ThemeData.dark() : ThemeData.light();
                Provider.of<ThemeProvider>(context, listen: false)
                    .setTheme(newTheme);
              },
            ),
            Text(
              Theme.of(context).brightness == Brightness.dark
                  ? 'Tema Oscuro'
                  : 'Tema Claro',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
