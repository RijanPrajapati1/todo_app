import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String title;
  final String description;
  final String category;
  final bool important;
  final String time;
  final bool check;

  TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.important,
    required this.time,
    required this.check,
  });

  // Add a factory constructor to create TaskModel from DocumentSnapshot
  factory TaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return TaskModel(
      title: data['title'],
      description: data['description'],
      category: data['category'],
      important: data['important'],
      time: data['time'].toString(), // Convert to String
      check: data['check'],
    );
  }

}
