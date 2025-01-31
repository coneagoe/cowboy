import 'package:flutter/material.dart';
import 'storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _storageService = StorageService();
  String _serverIp = '';
  String _port = '';
  String _proxy = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _storageService.loadSettings();
    setState(() {
      _serverIp = settings['serverIp'] ?? '';
      _port = settings['port'] ?? '';
      _proxy = settings['proxy'] ?? '';
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final settings = {
        'serverIp': _serverIp,
        'port': _port,
        'proxy': _proxy,
      };
      await _storageService.saveSettings(settings);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _serverIp,
                      decoration: const InputDecoration(labelText: 'Server IP'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter server IP';
                        }
                        return null;
                      },
                      onSaved: (value) => _serverIp = value!,
                    ),
                    TextFormField(
                      initialValue: _port,
                      decoration: const InputDecoration(labelText: 'Port'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter port';
                        }
                        return null;
                      },
                      onSaved: (value) => _port = value!,
                    ),
                    TextFormField(
                      initialValue: _proxy,
                      decoration: const InputDecoration(labelText: 'Proxy'),
                      onSaved: (value) => _proxy = value ?? '',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _saveSettings,
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
