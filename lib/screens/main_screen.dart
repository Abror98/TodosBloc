import 'package:bloc_sample/screens/all_task_screen.dart';
import 'package:bloc_sample/screens/done_task_screen.dart';
import 'package:bloc_sample/screens/process_task_page.dart';
import 'package:bloc_sample/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [AllTaskScreen.screen(),  ProcessTaskScreen.screen(), DoneTaskScreen.screen()];
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(label: "все", icon: Icon(Icons.list_alt_outlined)),
          BottomNavigationBarItem(label: "в прогрессе", icon: Icon(Icons.settings_backup_restore)),
          BottomNavigationBarItem(label: "выполнено", icon: Icon(Icons.done_outline)),
        ],
        currentIndex: selectedIndex,
        onTap: changeTap,
      ),
      body: pages[selectedIndex]
    );
  }

  void changeTap(int index){
    setState(() {
      selectedIndex = index;
    });
  }

 

}
