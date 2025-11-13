import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Task extends ParseObject implements ParseCloneable {
  Task() : super(_keyTableName);
  Task.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Task.clone()..fromJson(map);

  static const String _keyTableName = 'Task';
  static const String keyTitle = 'title';
  static const String keyDescription = 'description';
  static const String keyIsCompleted = 'isCompleted';
  static const String keyCreatedBy = 'createdBy';

  String? get title => get<String>(keyTitle);
  set title(String? value) => set<String>(keyTitle, value!);

  String? get description => get<String>(keyDescription);
  set description(String? value) => set<String>(keyDescription, value!);

  bool get isCompleted => get<bool>(keyIsCompleted) ?? false;
  set isCompleted(bool value) => set<bool>(keyIsCompleted, value);

  ParseUser? get createdBy => get<ParseUser>(keyCreatedBy);
  set createdBy(ParseUser? value) => set<ParseUser>(keyCreatedBy, value!);
}
