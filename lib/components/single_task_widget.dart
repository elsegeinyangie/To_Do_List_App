import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/cubit/list_cubit.dart';
import '../models/list_container_model.dart';

/*
  - each task (to-do) has a controller (takes control and updates text changes),
  - a singleTask object (to hold its data for each task (title, checked/unchecked))
*/

class SingleTaskWidget extends StatelessWidget {
  final TextEditingController controller;
  final SingleTask singleTask;

  const SingleTaskWidget({
    super.key,
    required this.controller,
    required this.singleTask,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SingleTaskCubit(SingleTaskState(singleTask.isChecked)),
      child: BlocBuilder<SingleTaskCubit, SingleTaskState>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: state.isChecked,
                onChanged: (newBool) {
                  context.read<SingleTaskCubit>().checkIsChecked(newBool ?? false);
                  singleTask.setIsChecked(newBool ?? false);
                },
                activeColor: Colors.black,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "To-Do",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    decoration: state.isChecked
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  onChanged: (title) {
                    singleTask.setTitle(title);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
