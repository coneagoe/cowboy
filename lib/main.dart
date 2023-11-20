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
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final config = Config();

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
            FutureBuilder<bool>(
              future: config.isConfigured(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListTile(
                    title: Text('Register/Unregister'),
                    onTap: snapshot.data == true
                        ? () {
                            Navigator.pushNamed(context, '/register');
                          }
                        : null,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      body: Center(),
    );
  }
}
