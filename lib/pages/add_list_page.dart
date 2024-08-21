import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list_app/cubit/list_cubit.dart';
import '../components/single_task_widget.dart';
import '../models/list_container_model.dart';

class AddListPage extends StatefulWidget {
  final void Function(ListContainer) addList;
  const AddListPage({super.key, required this.addList});

  @override
  State<AddListPage> createState() => _AddListStates();
}

class _AddListStates extends State<AddListPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AddListPageCubit(AddListPageState(
              textEditor: TextEditingController(),
              tasks: [],
              singleTaskLists: [])),
        ),
        BlocProvider(
          create: (context) => PinnedPressedCubit(false),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: BlocBuilder<PinnedPressedCubit, bool>(
                builder: (context, isPinnedPressed) {
                  return ElevatedButton.icon(
                    //todo: handlepinnedpressed function to cubit
                    onPressed: () {
                      context.read<PinnedPressedCubit>().togglePinnedPressed();
                    },
                    label: const Text("Pin List"),
                    icon: const FaIcon(
                      FontAwesomeIcons.mapPin,
                      size: 16.0,
                    ),
                    style: ButtonStyle(
                      backgroundColor: isPinnedPressed
                          ? const WidgetStatePropertyAll(Colors.black)
                          : const WidgetStatePropertyAll(Colors.white),
                      foregroundColor: isPinnedPressed
                          ? const WidgetStatePropertyAll(Colors.white)
                          : const WidgetStatePropertyAll(Colors.black),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<AddListPageCubit, AddListPageState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    controller: state.textEditor,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black54,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                    onChanged: (String value) {
                      context.read<AddListPageCubit>().updateTitle(value);
                    },
                    keyboardType: TextInputType.text,
                  ),
                  ...state.tasks,
                  InkWell(
                    //add to-do button
                    splashColor: Colors.transparent,
                    //todo: cubit method that adds a new singletask instance and singletaskwidget
                    onTap: () {
                      final singleTask = SingleTask(title: '');
                      final controller = TextEditingController();
                      context
                          .read<AddListPageCubit>()
                          .addToDoBtn(singleTask, controller);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 8),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.squarePlus,
                              color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "To-Do",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<AddListPageCubit, AddListPageState>(
          builder: (context, state) {
            return TextButton(
              //add list button
              onPressed: () {
                if (state.singleTaskLists.isNotEmpty) {
                  bool isPinPressed = context.read<PinnedPressedCubit>().state;

                  ListContainer listContainer = ListContainer(
                      title: state.textEditor.text,
                      toDos: state.singleTaskLists,
                      pinned: isPinPressed);
                  widget.addList(listContainer);
                  Navigator.pop(context);
                }
              },
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  fixedSize: WidgetStatePropertyAll(Size(350, 50))),
              child: const Text("Add List"),
            );
          },
        ),
      ),
    );
  }
}
