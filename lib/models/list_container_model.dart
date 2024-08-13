class ListContainer {
  final bool pinned;
  final String title;
  final List<SingleTask> toDos;

  const ListContainer(
      {this.pinned = false, required this.title, required this.toDos});

  @override
  String toString() {
    return 'List Title: $title, Pinned: $pinned, Tasks:${toDos.toString()}';
  }
}

class SingleTask {
  bool isChecked;
  String title;

  SingleTask({this.isChecked = false, required this.title});

  @override
  String toString() {
    return 'task: $title, checked: $isChecked';
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }
}
