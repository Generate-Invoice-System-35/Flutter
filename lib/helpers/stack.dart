class StackList<E> {
  late var _list = <E>[];

  StackList([List<E>? val]) {
    if (val != null) _list = val;
  }

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  void clear() => _list.clear();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
