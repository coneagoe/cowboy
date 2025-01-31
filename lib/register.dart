import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';
import 'dart:convert';
import 'user_table.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _passwordVisible = false;

  Future<String> _generateUserId(String username) async {
    final hostname = await _getHostname();
    final data = utf8.encode(hostname + username);
    final digest = md5.convert(data);
    return digest.toString();
  }

  Future<String> _getHostname() async {
    try {
      return Platform.localHostname;
    } catch (e) {
      // 如果无法获取主机名，返回一个默认值
      return 'unknown_host';
    }
  }

  Future<void> _register() async {
    final userId = await _generateUserId(usernameController.text);

    final database = await openDatabase(
      join(await getDatabasesPath(), 'cowboy.db'),
      version: 1,
    );

    await database.insert(
      UserTable.tableName,
      {
        UserTable.columnId: userId,
        UserTable.columnName: usernameController.text,
        UserTable.columnEmail: emailController.text,
        // 注意：在实际应用中，应该对密码进行加密处理
        'password': passwordController.text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // 可以在这里添加成功注册后的逻辑，比如显示一个提示或导航到其他页面
    /*
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Registration successful')),
    );
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register/Unregister'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement your unregistration logic here
                  },
                  child: const Text('Unregister'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
