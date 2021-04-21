enum Category { work, home, personal }

extension DataTransformations on Category {
  String getName() {
    return toString().split('.').last;
  }
}

enum TodoFilter {
  all,
  active,
  completed,
  onDate,
  beforeDate,
  afterDate,
  category,
  completedCategory,
}
