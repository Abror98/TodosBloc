part of 'custom_dialog_bloc.dart';

@immutable
abstract class CustomDialogEvent {}


class SaveCustomEvent extends CustomDialogEvent {
  final MyModel myModel;

  SaveCustomEvent({this.myModel});
}

class EditCustomEvent extends CustomDialogEvent {
  final MyModel myModel, oldModel;

  EditCustomEvent({this.myModel, this.oldModel});
}