
import 'package:bloc_sample/bloc/task/task_bloc.dart';
import 'package:bloc_sample/model/mymodel.dart';
import 'package:bloc_sample/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AllTaskScreen extends StatefulWidget {
  static Widget screen() => BlocProvider(
    create: (context) => TaskBloc(),
    child: AllTaskScreen(),
  );

  @override
  _AllTaskScreenState createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  TaskBloc bloc;

  openDialog(){
    showDialog(context: context, builder: (BuildContext context){
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 50),
          child: CustomDialog.screen(false),
        ),
      );
    }).then((_) => bloc.add(LoadEvent(id: 1)));
  }


  @override
  void initState() {
    bloc = BlocProvider.of<TaskBloc>(context);
    bloc.add(LoadEvent(id: 1));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Задачи"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.filter_list, color:Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("по сроку"),
              ),
              PopupMenuItem(
                child: Text("самые новые"),
              ),
              PopupMenuItem(
                child: Text("самые старые"),
              ),
            ],
          ),
          IconButton(icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                openDialog();
              }
          )
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskListErrorState) {
              final error = state.error;
              String message = '${error.message}';
              return Center(child: Text(message));
            }
            if (state is TaskLoadingState)
              return Center(child: SpinKitFadingCircle(color: Colors.grey));
            if (state is TaskLoadedState) {
              return ListView.builder(
                  itemCount: (state.list ?? []).length,
                  itemBuilder: (_, i) {
                    return itemWidget(state.list[i], i);
                  }
              );
            }
          }
      ),
    );
  }

  Card itemWidget(MyModel model, int id) => Card(
    child: Row(
      children: [
        SizedBox(width: 10),
        Text(model.name),
        Expanded(child: SizedBox()),
        Column(
          children: [
            Center(child: Text(model.date)),
            SizedBox(height: 20),
            Center(child: Text(model.status)),
          ],
        ),
        Column(
          children: [
            IconButton(icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
               bloc.add(DeleteEvent(name: model.name, date: model.date, status: model.status));
               bloc.add(LoadEvent(id: 1));
            }),
            SizedBox(height: 5),
            IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () {
              showDialog(context: context, builder: (BuildContext context){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 50),
                    child: CustomDialog.screenEdit(true, model.name, model.date, model.status),
                  ),
                );
              }).then((_) => bloc.add(LoadEvent(id: 1)));
            }),
          ],
        )
      ],
    ),
  );

}