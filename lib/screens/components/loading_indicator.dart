import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String desc;
  const LoadingIndicator({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(
          radius: 15,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          desc,
          style: TextStyle(color: Colors.black.withOpacity(0.5)),
        )
      ],
    ));
  }
}
