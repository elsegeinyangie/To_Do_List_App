import 'package:flutter/material.dart';
import '../models/list_container_model.dart';

/*
  - each task (to-do) has a controller (takes control and updates text changes),
  - a singleTask object (to hold its data for each task (title, checked/unchecked))
*/

class SingleTaskWidget extends StatefulWidget {
  final TextEditingController controller;
  final SingleTask singleTask;
  const SingleTaskWidget(
      {super.key, required this.controller, required this.singleTask});

  @override
  State<SingleTaskWidget> createState() => _SingleTaskWidgetState();
}

class _SingleTaskWidgetState extends State<SingleTaskWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (newBool) {
            setState(() {
              isChecked = newBool ?? false;
              widget.singleTask.setIsChecked(isChecked);
            });
          },
          activeColor: Colors.black,
        ),
        Expanded(
          child: TextField(
            controller: widget.controller,
            decoration: const InputDecoration(
              hintText: "To-Do",
              hintStyle: TextStyle(
                color: Colors.black38,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.zero, // Removes padding inside the TextField
            ),
            style: TextStyle(
              color: Colors.black,
              decoration:
                  isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            ),
            onChanged: (title) {
              widget.singleTask.setTitle(title);
            },
          ),
        ),
      ],
    );
  }
}
