import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({
    super.key,
    required this.controller,
    this.onChanged,
  });
  final TextEditingController controller;
  final Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 250,
        height: 250,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Todo Task",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "task",
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 97, 36, 36),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextButton(
                      onPressed: onChanged,
                      child: const Text("Add"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
