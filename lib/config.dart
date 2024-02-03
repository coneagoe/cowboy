import 'package:flutter/material.dart';

import 'config_data.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final serverIpController = TextEditingController();
  final serverPortController = TextEditingController();
  final proxyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    serverIpController.text = configData.serverIp ?? '';
    serverPortController.text = configData.serverPort?.toString() ?? '';
    proxyController.text = configData.proxy ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Config'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: serverIpController,
              onChanged: (value) {
                configData.serverIp = value;
              },
              decoration: const InputDecoration(
                labelText: 'Server IP',
              ),
            ),
            TextField(
              controller: serverPortController,
              onChanged: (value) {
                configData.serverPort = int.tryParse(value);
              },
              decoration: const InputDecoration(
                labelText: 'Server Port',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: proxyController,
              onChanged: (value) {
                configData.proxy = value;
              },
              decoration: const InputDecoration(
                labelText: 'Proxy',
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    saveConfigData(configData);
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
