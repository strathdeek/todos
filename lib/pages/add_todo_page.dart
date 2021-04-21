import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todos/data/bloc/todo/todo_bloc.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/utils/extensions.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  final Category category;

  const AddTodoPage(this.category);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  String _title = '';
  DateTime _dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.grey.shade600,
            ),
          ),
          title: Text(
            'New Task',
            style: TextStyle(color: Colors.grey.shade600),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Container(
                height: 100,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  decoration: InputDecoration(
                      focusColor: widget.category.getColor(),
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      labelText: 'What tasks are you planning to perform?',
                      border: InputBorder.none),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.list,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.category.getName(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: GestureDetector(
                  onTap: () async {
                    var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ) ??
                        DateTime.now();
                    setState(() {
                      _dueDate = date;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        _dueDate.isSameDate(DateTime.now())
                            ? 'Today'
                            : DateFormat.yMMMMd('en_US').format(_dueDate),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: widget.category.getColor()),
                        onPressed: () {
                          context.read<TodoBloc>().add(TodoAdded(
                              title: _title,
                              dueDate: _dueDate,
                              category: widget.category));
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.add)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
