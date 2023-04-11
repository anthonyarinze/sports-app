import 'package:flutter/material.dart';

Future<void> dialogBuilder(
    BuildContext context, String title, Function() func) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 2.0,
        scrollable: true,
        title: const Text('Info'),
        content: Text(title),
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: func,
              child: const Text('Yes')),
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      );
    },
  );
}

class BuildProfileListTile extends StatelessWidget {
  final Function() onTap;
  final Icon leadingIcon;
  final String title;
  final Icon? trailingIcon;

  const BuildProfileListTile({
    super.key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border.symmetric(
            horizontal: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        child: ListTile(
          leading: leadingIcon,
          title: Text(title,
              style: const TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              )),
          trailing: trailingIcon,
        ),
      ),
    );
  }
}
