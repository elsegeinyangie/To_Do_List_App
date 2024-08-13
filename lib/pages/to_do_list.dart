import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list_app/pages/add_list.dart';
import '../models/list_container_model.dart';
import '../components/list_container_widget.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Set<String> _selected = {'All Lists'};

  void updateSelection(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }

  List<Widget> allLists = [];
  List<Widget> pinnedLists = [];

  void addList(ListContainer ls) {
    ListContainerWidget newList = ListContainerWidget(
        pinned: ls.pinned, listTitle: ls.title, tasksList: ls.toDos);

    allLists.add(newList);
    if (ls.pinned) {
      pinnedLists.add(newList);
    }
    debugPrint(ls.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.listCheck),
          iconSize: 20.0,
          color: Colors.black,
        ),
        title: const Text(
          "Dooit",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: false,
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: const <ButtonSegment<String>>[
                    ButtonSegment(
                      value: "All Lists",
                      label: Text("All Lists"),
                    ),
                    ButtonSegment(
                      value: "Pinned",
                      label: Text("Pinned"),
                    ),
                  ],
                  selected: _selected,
                  onSelectionChanged: updateSelection,
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.black; // Background color when selected
                        }
                        return Colors.grey
                            .shade200; // Background color when not selected
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white; // Text color when selected
                        }
                        return Colors
                            .grey.shade800; // Text color when not selected
                      },
                    ),
                    textStyle:
                        const WidgetStatePropertyAll(TextStyle(fontSize: 18.0)),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      (_selected.contains("All Lists") ? allLists : pinnedLists)
                          .length,
                  itemBuilder: (context, index) {
                    return (_selected.contains("All Lists")
                        ? allLists
                        : pinnedLists)[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddList(
                addList: addList,
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          size: 20.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
