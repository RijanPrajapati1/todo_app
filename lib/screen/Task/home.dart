import 'package:flutter/material.dart';
import 'package:todo_app/screen/Login/login_screen.dart'; // Import the LoginScreen
import 'package:todo_app/screen/Task/addtask_screen.dart';
import 'package:todo_app/screen/Task/task_screen.dart';
import '../../Profile/profile_screen.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

List<Widget> screens = [TaskScreen(), Addtask(), ProfileScreen()];

class _HomeState extends State<Home> {
  int currentidx = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Wrap with WillPopScope to handle back button press
      onWillPop: () async {
        if (currentidx == 0) {
          // If on the TaskScreen, pop until the LoginScreen
          Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
          return true;
        }
        setState(() {
          // Move to the previous screen
          currentidx = (currentidx - 1).clamp(0, screens.length - 1);
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Add logout functionality here
                // For example, navigate to the login screen
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
              },
            ),
          ],
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
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: currentidx == 0
            ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addtask()),
            );
          },
          child: Icon(Icons.add),
        )
            : null,
      ),
    );
  }
}
