import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import 'dart:io';

const config_file_name = 'config.yaml';

class Config {
  static String? serverIp;
  static int? serverPort;
  static String? proxy;

  Config() {
    load();
  }

  Future<void> load() async {
    final file = File(config_file_name);
    if (!await file.exists()) {
      return;
    }

    final yaml = loadYaml(await file.readAsString());
    serverIp = yaml['serverIp'];
    serverPort = yaml['serverPort'];
    proxy = yaml['proxy'];
  }

  Future<void> save() async {
    final file = File(config_file_name);
    await file.writeAsString(
        'serverIp: $serverIp\nserverPort: $serverPort\n$proxy: $proxy\n');
  }
}

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final config = Config();
  final serverIpController = TextEditingController(text: Config.serverIp);
  final serverPortController =
      TextEditingController(text: Config.serverPort?.toString());
  final proxyController = TextEditingController(text: Config.proxy);
  bool isModified = false;

  @override
  void initState() {
    super.initState();
    _loadConfig();
    serverIpController.addListener(_checkIfModified);
    serverPortController.addListener(_checkIfModified);
    proxyController.addListener(_checkIfModified);
  }

  void _loadConfig() async {
    await config.load();
    setState(() {
      serverIpController.text = Config.serverIp ?? "";
      serverPortController.text = Config.serverPort?.toString() ?? "";
      proxyController.text = Config.proxy ?? "";
    });
  }

  @override
  void dispose() {
    serverIpController.dispose();
    serverPortController.dispose();
    proxyController.dispose();
    super.dispose();
  }

  void _checkIfModified() {
    setState(() {
      isModified = serverIpController.text != Config.serverIp ||
          serverPortController.text != Config.serverPort?.toString() ||
          proxyController.text != Config.proxy;
    });
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
                Config.serverIp = value;
              },
              controller: serverIpController,
              decoration: InputDecoration(
                labelText: 'Server IP',
              ),
            ),
            TextField(
              onChanged: (value) {
                Config.serverPort = int.tryParse(value);
              },
              controller: serverPortController,
              decoration: InputDecoration(
                labelText: 'Server Port',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (value) {
                Config.proxy = value;
              },
              controller: proxyController,
              decoration: InputDecoration(
                labelText: 'Proxy',
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isModified ? config.save : null,
                  child: Text('Save'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
