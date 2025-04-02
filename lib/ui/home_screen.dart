import 'package:bloc_flutter/bloc/list/list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/list/list_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard Screen',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if(state.list.isEmpty){
            return Center(child: Text('No List Found'),);
          }else if(state.list.isNotEmpty){
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.list[index]),
                    trailing: IconButton(
                        onPressed: () {}, icon: Icon(Icons.delete)),
                  );
                });
          }else{
            return const SizedBox();
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i =0;i<10;i++){
            context.read<ListBloc>().add(AddListEvent(task:'Task;'+i.toString() ));
          }
          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
