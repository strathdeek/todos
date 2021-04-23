import 'package:equatable/equatable.dart';
import 'package:todos/data/models/category.dart';
import 'package:todos/data/models/todo.dart';
import 'package:todos/utils/extensions.dart';

class TodoFilter extends Equatable {
  final DateTime? date;
  final DateFilterType? dateFilter;
  final Category? category;
  final bool? done;
  final bool filterByCategory;
  final bool filterByDone;
  final bool filterByDate;

  TodoFilter(
      {required this.filterByDate,
      this.date,
      this.dateFilter,
      this.category,
      required this.filterByCategory,
      this.done,
      required this.filterByDone});

  @override
  List<Object?> get props =>
      [date, dateFilter, category, filterByCategory, done];

  List<Todo> filter(List<Todo> todos) {
    var filteredTodos = todos;
    if (filterByDate) {
      switch (dateFilter) {
        case DateFilterType.afterDate:
          filteredTodos = filteredTodos
              .where((element) => element.dueDate
                  .isAfter(date?.endOfDay() ?? DateTime.now().endOfDay()))
              .toList();
          break;
        case DateFilterType.onDate:
          filteredTodos = filteredTodos
              .where((element) =>
                  element.dueDate.isSameDate(date ?? DateTime.now()))
              .toList();
          break;
        case DateFilterType.beforeDate:
          filteredTodos = filteredTodos
              .where((element) => element.dueDate
                  .isBefore(date?.startOfDay() ?? DateTime.now().startOfDay()))
              .toList();
          break;
        default:
          break;
      }
    }
    if (filterByCategory) {
      filteredTodos = filteredTodos
          .where((element) => element.category == category)
          .toList();
    }
    if (filterByDone) {
      filteredTodos =
          filteredTodos.where((element) => element.done == done).toList();
    }
    return filteredTodos;
  }
}

enum DateFilterType { beforeDate, onDate, afterDate }
