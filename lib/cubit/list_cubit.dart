// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/components/single_task_widget.dart';

import '../models/list_container_model.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListState.initialState());

  List<ListContainer> updatedAllLists = [];
  List<ListContainer> updatedPinnedList = [];

  void addList(ListContainer ls) {
    updatedAllLists = List.from(state.allLists)..add(ls);
    if (ls.pinned) {
      updatedPinnedList = List.from(state.pinnedLists)..add(ls);
    }

    emit(ListState(allLists: updatedAllLists, pinnedLists: updatedPinnedList));
  }
}

class ListState {
  List<ListContainer> allLists = [];
  List<ListContainer> pinnedLists = [];

  ListState({
    required this.allLists,
    required this.pinnedLists,
  });

  ListState.initialState() {
    ListState(allLists: [], pinnedLists: []);
  }
}

/////////////////////////////////

class SingleTaskCubit extends Cubit<SingleTaskState> {
  SingleTaskCubit(super.initialState);

  bool singleTaskCheck = false;

  void checkIsChecked(bool newCheck) {
    singleTaskCheck = newCheck;
    emit(SingleTaskState(singleTaskCheck));
  }
}

class SingleTaskState {
  bool isChecked = false;

  SingleTaskState(this.isChecked);
}

////////////////////////////////

////////////////////////////////

class PinnedPressedCubit extends Cubit<bool> {
  PinnedPressedCubit(super.initialState);

  bool pinPressed = false;
  void handlePinnedPress(bool newPin) {
    pinPressed = newPin;
    emit(pinPressed);
  }

  void togglePinnedPressed() {
    emit(!state);
  }
}

class AddListPageCubit extends Cubit<AddListPageState> {
  AddListPageCubit(super.initialState);

  void addToDoBtn(SingleTask singleTask, TextEditingController controller) {
    state.singleTaskLists.add(singleTask);
    state.controllers.add(state.controller);
    state.tasks.add(
      SingleTaskWidget(
        controller: state.controller,
        singleTask: singleTask,
      ),
    );

    emit(AddListPageState(
      textEditor: state.textEditor,
      tasks: List.from(state.tasks),
      singleTaskLists: List.from(state.singleTaskLists),
    ));
  }

  void updateTitle(String newTitle) {
    // Update the state by creating a new AddListPageState with the updated title
    state.textEditor.text = newTitle;
    // Emit the updated state
    emit(AddListPageState(
      textEditor: state.textEditor,
      tasks: state.tasks,
      singleTaskLists: state.singleTaskLists,
    ));
  }
}

class AddListPageState {
  TextEditingController textEditor = TextEditingController();
  List<TextEditingController> controllers = [];
  List<SingleTask> singleTaskLists = [];
  List<Widget> tasks = [];
  final TextEditingController controller = TextEditingController();

  AddListPageState({
    required this.textEditor,
    required this.tasks,
    required this.singleTaskLists,
  });

  AddListPageState.initialState() {
    AddListPageState(
      textEditor: TextEditingController(),
      tasks: [],
      singleTaskLists: [],
    );
  }
}
