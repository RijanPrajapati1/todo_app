import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screen/Task/task_card.dart';
import '../../model/task_model.dart';
import '../../provider/task_view_model.dart';

// Define an enum for task categories
enum TaskCategory {
  Work,
  Personal,
  Errands,
  // Add more categories as needed
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskViewModel _viewModel = TaskViewModel();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff030404),
      appBar: AppBar(
        backgroundColor: Color(0xff616B7B),
        centerTitle: true,
        title: Title(
          color: Colors.green,
          child: Text(
            "Tasks",
            style: GoogleFonts.robotoCondensed(color: Colors.white),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _viewModel.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              TaskModel task = TaskModel.fromSnapshot(snapshot.data!.docs[index]);


              // Use the enum to set the category
              TaskCategory category;
              switch (index % 3) {
                case 0:
                  category = TaskCategory.Work;
                  break;
                case 1:
                  category = TaskCategory.Personal;
                  break;
                case 2:
                  category = TaskCategory.Errands;
                  break;
                default:
                  category = TaskCategory.Work;
              }

              return GestureDetector(
                onTap: () {
                  // Handle task tap
                },
                onLongPress: () {
                  // Handle long press
                },
                child: TaskCard(
                  title: task.title,
                  description: task.description,
                  imp: task.important,
                  time: task.time,
                  check: task.check,
                  id: snapshot.data!.docs[index].id, idx: 19,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
