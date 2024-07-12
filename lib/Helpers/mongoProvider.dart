import 'package:mongo_dart/mongo_dart.dart';
import 'package:portfolio/Constants/constants.dart';
import 'package:portfolio/Models/ProjectModel.dart';
import 'package:flutter/material.dart';

class MongoProvider extends ChangeNotifier {

  Db? _db;
  late DbCollection _collection;

  Db? get db => _db;

  Future<void> connectToMongo() async {
    try {
      _db = await Db.create(mongoUrl);
      await _db!.open();
      // _collection = _db!.collection("projects");
      notifyListeners();
    } catch (e) {
      print("Error connecting to MongoDB: $e");
      rethrow;
    }
  }

  Future<List<project>> getProjects() async {
    List<project> projects = [];
    try {
      final List<Map<String, dynamic>> data = await _collection.find().toList();
      projects = data.map((json) => project.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching projects: $e");
    }
    return projects;
  }


}
