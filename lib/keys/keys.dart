import 'package:flutter/material.dart';
// import 'package:udemyappfirst/keys/todo_item.dart';
import 'package:udemyappfirst/keys/checkable_todo_item.dart';

// 型定義って、 ふつうに class だけでもいいのか
class Todo {
  // これ　あは　swiftの,inintという認識であてrうあk
  const Todo(this.text, this.priority);
  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});
  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  // class　ないの、  varは、 state() で再描写で更新してね
  var _order = 'asc';

  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  // なんか　wiged の中で 配列を作る時にここの List<Todo>を作らないとなの謎いけど定石っぽいな
  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  // class内の、 var を変えた買ったら、
//  ①  上で変数を定義して、
//  ②   struct内で、　トリガーを定義して
//  ③　 void　で setState()　の関数を定義する

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _changeOrder,
            icon: Icon(
              _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
            ),
            label: Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              // for (final todo in _orderedTodos) TodoItem(todo.text, todo.priority),
              for (final todo in _orderedTodos)
                CheckableTodoItem(
                  key: ObjectKey(todo), // ValueKey()
                  todo.text,
                  todo.priority,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
