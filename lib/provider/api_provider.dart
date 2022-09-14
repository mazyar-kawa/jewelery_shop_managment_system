import 'package:flutter/cupertino.dart';

class ApiProvider with ChangeNotifier {
  dynamic data;
  Map<dynamic, dynamic>? error;
}
