import 'package:flutter/material.dart';
import 'package:todo_app/screen/Task/addtask_screen.dart';
import 'package:todo_app/screen/Task/task_screen.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

List<Widget> screens = [TaskScreen(), Addtask()];

class _HomeState extends State<Home> {
  int currentidx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: screens[currentidx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentidx,
        onTap: (int index) {
          setState(() {
            currentidx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: currentidx == 0
          ? FloatingActionButton(
        onPressed: () {
          // Navigate to AddTask screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addtask()),
          );
        },
        child: Icon(Icons.add),
      )
          : null,
    );
  }
}
