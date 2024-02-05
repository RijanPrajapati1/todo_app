// task_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTasksStream() {
    return _firestore.collection('Tasks').snapshots();
  }

  Future<void> deleteTask(String taskId) {
    return _firestore.collection('Tasks').doc(taskId).delete();
  }
}
