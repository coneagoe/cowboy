import 'dart:io';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

const configFileName = 'config.json';

late ConfigData configData = loadConfigData();

@JsonSerializable()
class ConfigData {
  String? serverIp;
  int? serverPort;
  String? proxy;

  ConfigData({
    this.serverIp,
    this.serverPort,
    this.proxy,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) =>
      _$ConfigDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigDataToJson(this);
}

ConfigData _$ConfigDataFromJson(Map<String, dynamic> json) {
  return ConfigData(
    serverIp: json['serverIp'] as String?,
    serverPort: json['serverPort'] as int?,
    proxy: json['proxy'] as String?,
  );
}

Map<String, dynamic> _$ConfigDataToJson(ConfigData instance) =>
    <String, dynamic>{
      'serverIp': instance.serverIp,
      'serverPort': instance.serverPort,
      'proxy': instance.proxy,
    };

ConfigData loadConfigData() {
  final file = File(configFileName);
  if (!file.existsSync()) {
    return ConfigData();
  }

  final contents = file.readAsStringSync();
  final json = jsonDecode(contents);
  return ConfigData.fromJson(json);
}

void saveConfigData(ConfigData configData) {
  final file = File(configFileName);
  final contents = jsonEncode(configData.toJson());
  file.writeAsStringSync(contents);
}
