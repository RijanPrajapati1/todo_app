// task_view_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository/task_repository.dart';

class TaskViewModel {
  final TaskRepository _repository = TaskRepository();

  Stream<QuerySnapshot> getTasksStream() {
    return _repository.getTasksStream();
  }

  Future<void> deleteTask(String taskId) {
    return _repository.deleteTask(taskId);
  }
}
