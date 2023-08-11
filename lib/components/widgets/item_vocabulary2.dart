import 'package:flash_card_learn_english/models/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// hiển thị từ vựng và nghĩa của từ
class ItemVocabulary2 extends StatefulWidget {
  ItemVocabulary2({super.key, required this.vocabulary});
  Vocabulary vocabulary;
  @override
  State<ItemVocabulary2> createState() => _ItemVocabulary2State();
}

class _ItemVocabulary2State extends State<ItemVocabulary2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(widget.vocabulary.color),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(2, 2))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.vocabulary.terms,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(widget.vocabulary.textColor),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.vocabulary.define,
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(widget.vocabulary.textColor),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
