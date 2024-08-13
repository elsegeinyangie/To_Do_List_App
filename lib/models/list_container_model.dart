class ListContainer {
  final bool pinned;
  final String title;
  final List<SingleTask> toDos;

  const ListContainer(
      {this.pinned = false, required this.title, required this.toDos});
}

class SingleTask {
  bool isChecked;
  String title;

  SingleTask({this.isChecked = false, required this.title});

  @override
  String toString() {
    return "{title: $title , isChecked: $isChecked}";
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }
}
