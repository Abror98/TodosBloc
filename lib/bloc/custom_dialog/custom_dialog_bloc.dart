import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/bloc/task/task_bloc.dart';
import 'package:bloc_sample/di/locator.dart';
import 'package:bloc_sample/model/mymodel.dart';
import 'package:bloc_sample/repository/repository.dart';
import 'package:bloc_sample/widgets/error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'custom_dialog_event.dart';
part 'custom_dialog_state.dart';

class CustomDialogBloc extends Bloc<CustomDialogEvent, CustomDialogState> {
  final DataRepository dataRepository = locator.get<DataRepository>();
  BuildContext context;
  CustomDialogBloc(this.context) : super(CustomDialogInitial());

  @override
  Stream<CustomDialogState> mapEventToState(
    CustomDialogEvent event,
  ) async* {
    if(event is SaveCustomEvent)
      yield* saveFunc(event);
    if(event is EditCustomEvent)
      yield* editFunc(event);
  }

  Stream<CustomDialogState> saveFunc(SaveCustomEvent insertEvent) async* {
       await dataRepository.insertItems(insertEvent.myModel);
  }

  Stream<CustomDialogState> editFunc(EditCustomEvent event) async* {
    await dataRepository.updateItems(event.myModel, event.oldModel);
  }

}
