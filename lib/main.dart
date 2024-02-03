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
        '/': (context) => const HomePage(),
        '/config': (context) => const ConfigPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Config'),
              onTap: () {
                Navigator.pushNamed(context, '/config');
              },
            ),
            ListTile(
              title: const Text('Register'),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
      body: const Center(),
    );
  }
}
