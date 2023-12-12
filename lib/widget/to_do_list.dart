import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteAtIndex,
  });
  final String taskName;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext)? deleteAtIndex;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteAtIndex,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // color: Colors,
          color: Colors.yellow[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(2, 2),
              blurRadius: 12,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Checkbox(
            onChanged: onChanged,
            value: taskCompleted,
            fillColor: MaterialStatePropertyAll(
              taskCompleted ? Colors.grey : Colors.white,
            ),
          ),
          title: Text(
            taskName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: taskCompleted ? Colors.grey : Colors.black,
                ),
          ),
          trailing: Visibility(
            visible: taskCompleted,
            child: Text(
              "Completed",
              // textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
