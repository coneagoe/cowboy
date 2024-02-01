import 'package:flutter/material.dart';
import 'config.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cowboy',
      theme: ThemeData(
          // theme configuration here
          ),
      routes: {
        '/': (context) => HomePage(),
        '/config': (context) => ConfigPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Config'),
              onTap: () {
                Navigator.pushNamed(context, '/config');
              },
            ),
          ],
        ),
      ),
      body: Center(),
    );
  }
}
