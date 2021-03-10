import 'package:bloc_sample/bloc/custom_dialog/custom_dialog_bloc.dart';
import 'package:bloc_sample/model/drop_down_model.dart';
import 'package:bloc_sample/model/mymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDialog extends StatefulWidget {
  String name, date, status;
  bool edit = false;


  CustomDialog({this.name, this.date, this.status, this.edit});

  static Widget screenEdit(bool edit, String name, String date, String status) => BlocProvider(
    create: (context) => CustomDialogBloc(context),
    child: CustomDialog(name: name, date: date, status: status, edit: edit),
  );

  static Widget screen() => BlocProvider(
    create: (context) => CustomDialogBloc(context),
    child: CustomDialog(),
  );



  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  DropDownModel selectedItems;
  TextEditingController nameController = TextEditingController();
  CustomDialogBloc bloc;
  DropDownModel selectStatus;

  String dateHintInt = '1';
  String statusHintText = "в прогрессе";

  List<DropDownModel> listStatus = <DropDownModel> [
    DropDownModel('выполнено'),
    DropDownModel('в прогрессе'),
  ];
  List<DropDownModel> items = <DropDownModel>[
    DropDownModel('1'),
    DropDownModel('2'),
    DropDownModel('3'),
    DropDownModel('5'),
    DropDownModel('7'),
    DropDownModel('10'),
    DropDownModel('15'),
    DropDownModel('20'),
  ];


  @override
  void initState() {
    bloc = BlocProvider.of<CustomDialogBloc>(context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.blue, spreadRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(height: 8),
                  Text(" с полями название: "),
                  SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      height: 30,
                      child: TextField(
                        controller: nameController,
                      ),

                    ),
                  ),
                ],
              ),
             Row(
               children: [
                 Text("срок (дата): "),
                 Expanded(child: SizedBox()),
                 DropdownWidget(),
               ],
             ),
              Row(
                children: [
                  Text("статус: "),
                  Expanded(child: SizedBox()),
                  DropdownStatusWidget(),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  FlatButton(onPressed: (){
                    Navigator.pop(context);
                  }, color: Colors.blue, child: Text("cancel", style: TextStyle(color: Colors.white),)),
                  Expanded(child: SizedBox()),
                  FlatButton(onPressed: (){
                    MyModel myModel = MyModel(name: nameController != null ? nameController.text : "Нет информации", status: selectStatus != null ? selectStatus.name: (widget.edit ? widget.status : statusHintText), date: selectedItems != null ? selectedItems.name : (widget.edit ? widget.date : dateHintInt));
                    if(widget.edit){
                      MyModel oldmodel = MyModel(name: widget.name, date: widget.date, status: widget.status);
                      bloc.add(EditCustomEvent(myModel: myModel, oldModel: oldmodel));
                    }
                   else
                    bloc.add(SaveCustomEvent(myModel: myModel));
                    Navigator.pop(context);

                  }, color: Colors.blue, child: Text(widget.edit ? "update" : "save", style: TextStyle(color: Colors.white),)),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


  DropdownButton DropdownWidget() =>
      DropdownButton<DropDownModel>(
        hint: Text(widget.edit ? widget.date: dateHintInt.toString()),
        value: selectedItems,
        onChanged: (DropDownModel Value) {
          setState(() {
            selectedItems = Value;
          });
        },
        items: items.map((DropDownModel user) {
          return  DropdownMenuItem<DropDownModel>(
            value: user,
            child: Row(
              children: <Widget>[
                Text(
                  user.name,
                  style:  TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      );

  DropdownButton DropdownStatusWidget() =>
      DropdownButton<DropDownModel>(
        hint:  Text(widget.edit ? widget.status : statusHintText),
        value: selectStatus,
        onChanged: (DropDownModel Value) {
          setState(() {
            selectStatus = Value;
          });
        },
        items: listStatus.map((DropDownModel user) {
          return  DropdownMenuItem<DropDownModel>(
            value: user,
            child: Row(
              children: <Widget>[
                Text(
                  user.name,
                  style:  TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      );
}
