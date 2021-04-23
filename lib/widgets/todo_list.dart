import 'package:flutter/material.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/models/index.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({Key? key, required this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        primary: false,
        separatorBuilder: (context, index) => Divider(),
        itemCount: todos.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Checkbox(
              value: todos[index].done,
              onChanged: (done) {
                if (done == null) {
                  return;
                }
                context
                    .read<TodoBloc>()
                    .add(TodoDoneToggled(todos[index], done));
              }),
          title: Text(
            todos[index].title,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () =>
                context.read<TodoBloc>().add(TodoDeleted(todos[index])),
          ),
        ),
      ),
    );
  }
}
