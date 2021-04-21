enum Category { work, home, personal }

extension DataTransformations on Category {
  String toMap() {
    return toString().split('.').last;
  }
}
