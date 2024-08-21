import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/to_do_list.dart';
import 'cubit/list_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListCubit>.value(
          value: ListCubit(),
        ),
        BlocProvider<AddListPageCubit>.value(
          value: AddListPageCubit(AddListPageState(textEditor: TextEditingController(), tasks: [], singleTaskLists: [])),
        ),
      ],
      child: const MaterialApp(
        home: ToDoList(),
      ),
    );
  }
}
