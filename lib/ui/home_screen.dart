import 'package:bloc_flutter/bloc/list/list_bloc.dart';
import 'package:bloc_flutter/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list/list_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListBloc(),
      child: HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  int taskCounter =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Dashboard Screen',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state.list.isEmpty) {
            return Center(child: Text('No List Found'));
          } else {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.list[index]),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<ListBloc>().add(RemoveListEvent(task: state.list[index]));
                    },
                    icon: Icon(Icons.delete),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context, state.list[index]);
                    },
                  ),

                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskCounter++;
          context.read<ListBloc>().add(AddListEvent(task: 'Task $taskCounter'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void _showEditDialog(BuildContext context, String oldTask) {
    TextEditingController controller = TextEditingController(text: oldTask);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter new task"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<ListBloc>().add(
                    UpdateListEvent(oldTask: oldTask, newTask: controller.text),
                  );
                  if (kDebugMode) {
                    print('update......');
                  }
                  Navigator.pop(context);
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
