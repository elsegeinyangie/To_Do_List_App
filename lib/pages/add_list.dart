import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list_app/components/single_task_widget.dart';
import 'package:to_do_list_app/models/list_container_model.dart';

class AddList extends StatefulWidget {
  final void Function(ListContainer) addList;
  const AddList({super.key, required this.addList});

  @override
  State<AddList> createState() => _AddListStates();
}

class _AddListStates extends State<AddList> {
  bool _isPinnedPressed = false;

  void _handlePinnedPress() {
    setState(() {
      _isPinnedPressed = !_isPinnedPressed;
    });
  }

  final TextEditingController textEditingController = TextEditingController();
  final List<TextEditingController> controllers = [];
  final List<SingleTask> singleTaskLists = [];
  String titleText = '';

  List<Widget> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _handlePinnedPress,
              label: const Text("Pin List"),
              icon: const FaIcon(
                FontAwesomeIcons.mapPin,
                size: 16.0,
              ),
              style: ButtonStyle(
                backgroundColor: _isPinnedPressed
                    ? const WidgetStatePropertyAll(Colors.black)
                    : const WidgetStatePropertyAll(Colors.white),
                foregroundColor: _isPinnedPressed
                    ? const WidgetStatePropertyAll(Colors.white)
                    : const WidgetStatePropertyAll(Colors.black),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
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
              onSubmitted: (String value) {
                setState(() {
                  titleText = textEditingController.text;
                });
              },
              keyboardType: TextInputType.text,
            ),
            ...tasks,
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      SingleTask singleTask = SingleTask(title: '');
                      singleTaskLists.add(singleTask);
                      final TextEditingController controller =
                          TextEditingController();
                      controllers.add(controller);
                      tasks.add(SingleTaskWidget(
                        controller: controller,
                        singleTask: singleTask,
                      ));
                    });
                  },
                  icon: const FaIcon(FontAwesomeIcons.squarePlus),
                  color: Colors.black,
                ),
                const Text(
                  "To-Do",
                  style: TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          if (singleTaskLists.isNotEmpty) {
            for (SingleTask s in singleTaskLists) {
              if (s.title.isEmpty) {
                debugPrint("title is empty.");
                return;
              }
              debugPrint(s.toString());
            }
            ListContainer listContainer = ListContainer(
                title: textEditingController.text,
                toDos: singleTaskLists,
                pinned: _isPinnedPressed);
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
      ),
    );
  }
}
