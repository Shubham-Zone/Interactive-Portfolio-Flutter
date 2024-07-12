import 'package:flutter/material.dart';

class ProjectsProvider extends ChangeNotifier {
  int _idx = 0;

  int get idx => _idx;

  void updateIndex(int newIndex) {
    _idx = newIndex;
    notifyListeners();
  }
}
