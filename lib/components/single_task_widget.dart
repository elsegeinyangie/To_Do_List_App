import 'package:flutter/material.dart';
import '../models/list_container_model.dart';

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
    return CheckboxListTile(
      title: TextField(
        controller: widget.controller,
        decoration: const InputDecoration(
          hintText: "To-Do",
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          decoration:
              isChecked! ? TextDecoration.lineThrough : TextDecoration.none,
        ),
        onChanged: (title) {
          widget.singleTask.setTitle(title);
        },
      ),
      value: isChecked,
      onChanged: (newBool) {
        setState(() {
          isChecked = newBool ?? false;
          widget.singleTask.setIsChecked(isChecked);
          const TextStyle(decoration: TextDecoration.lineThrough);
        });
      },
      activeColor: Colors.black,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
