import 'package:flutter/material.dart';

class DismissibleWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const DismissibleWidget({
    required this.child,
    required this.onDismissed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key ?? UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(3),
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
