import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {
  final String question;
  final void Function(String) onTap;
  const QuestionItem({super.key, required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(question);
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.65),
        ),
        child: ListTile(
          dense: true,
          // negative value to compact, positive to expand
          visualDensity: const VisualDensity(vertical: -3),
          contentPadding:
              const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 0),
          leading: const Icon(
            Icons.lightbulb_outlined,
            color: Colors.amber,
          ),
          title: Transform.translate(
            //Default value of minLeadingWidth is 40, so to reduce space between leading and title by x pass minLeadingWidth: 40 - x
            offset: const Offset(-20, 0),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  question,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
