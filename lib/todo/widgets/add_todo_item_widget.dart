import 'package:flutter/material.dart';

import 'package:todo/todo/providers/todo_provider.dart';

class AddTodoItemWidget extends StatefulWidget {
  final TodosProvider provider;

  const AddTodoItemWidget({required this.provider, Key? key}) : super(key: key);

  @override
  State<AddTodoItemWidget> createState() => _AddTodoItemWidgetState();
}

class _AddTodoItemWidgetState extends State<AddTodoItemWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Tap to add new item',
              ),
              controller: _controller,
              onChanged: (_) => setState(() {}),
              onSubmitted: (title) {
                widget.provider.addTodo(title);
                _controller.clear();
              },
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                FocusScope.of(context).unfocus();
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
