// user_task.dart
class UserTask {
  final String taskId;
  final String userId;
  final String taskName;
  final String taskDescription;
  final bool isCompleted;

  UserTask({
    required this.taskId,
    required this.userId,
    required this.taskName,
    required this.taskDescription,
    required this.isCompleted,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      taskId: json['taskId'] ?? '',
      userId: json['userId'] ?? '',
      taskName: json['taskName'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
