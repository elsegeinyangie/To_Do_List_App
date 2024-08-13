import 'package:flutter/material.dart';
import '../models/list_container_model.dart';
import './single_task_widget.dart';

class ListContainerWidget extends StatefulWidget {
  final bool pinned;
  final String listTitle;
  List<SingleTask> tasksList = [];

  ListContainerWidget(
      {super.key,
      this.pinned = false,
      required this.listTitle,
      required this.tasksList});

  @override
  State<ListContainerWidget> createState() => _ListContainerWidgetState();
}

class _ListContainerWidgetState extends State<ListContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: const Color.fromARGB(105, 113, 186, 245),
        border: Border.all(
          width: 1.0,
          color: Colors.black,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title of list
          Text(
            widget.listTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          //tasks list
          const SizedBox(height: 8.0),
          ...widget.tasksList.map((task) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: SingleTaskWidget(
                controller: TextEditingController(text: task.title),
                singleTask: task,
              ),
            );
          }),
        ],
      ),
    );
  }
}
