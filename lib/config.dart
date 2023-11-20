import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

const config_file_name = 'config.yaml';

class Config {
  String? serverIp;
  int? serverPort;

  Config({this.serverIp, this.serverPort});

  void load() {
    final file = File(config_file_name);
    if (!file.existsSync()) {
      return;
    }

    final yaml = loadYaml(file.readAsStringSync());
    serverIp = yaml['serverIp'];
    serverPort = yaml['serverPort'];
  }

  void save() {
    final file = File(config_file_name);
    file.writeAsString('serverIp: $serverIp\nserverPort: $serverPort\n');
  }

  bool isConfigured() {
    final file = File(config_file_name);
    if (!file.existsSync()) {
      return false;
    }

    load();

    return serverIp != null && serverPort != null;
  }
}

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final config = Config();

  @override
  void initState() {
    super.initState();
    config.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                config.serverIp = value;
              },
              controller: TextEditingController(text: config.serverIp),
              decoration: InputDecoration(
                labelText: 'Server IP',
              ),
            ),
            TextField(
              onChanged: (value) {
                config.serverPort = int.tryParse(value);
              },
              controller:
                  TextEditingController(text: config.serverPort?.toString()),
              decoration: InputDecoration(
                labelText: 'Server Port',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: config.save,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
