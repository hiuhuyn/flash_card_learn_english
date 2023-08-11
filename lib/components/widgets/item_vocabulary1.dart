import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/vocabulary.dart';

// hiển thị tất cả thông tin từ vựng
class ItemVocabulary1 extends StatefulWidget {
  ItemVocabulary1({super.key, required this.vocabulary});
  Vocabulary vocabulary;

  @override
  State<ItemVocabulary1> createState() => _ItemVocabulary1State();
}

class _ItemVocabulary1State extends State<ItemVocabulary1>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_status == AnimationStatus.dismissed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(2, 1, 0.0015)
          ..rotateX(pi * _animation.value),
        child: _animation.value <= 0.5 ? _item1() : _item2(),
      ),
    );
  }

  Widget _item1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(widget.vocabulary.color),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(2, 2))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.vocabulary.terms,
            style: TextStyle(
                fontSize: 20.sp,
                color: Color(widget.vocabulary.textColor),
                fontWeight: FontWeight.bold),
          ),
          Visibility(
            visible: widget.vocabulary.spelling == "" ? false : true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.vocabulary.spelling,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontStyle: FontStyle.italic,
                      color: Color(widget.vocabulary.textColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item2() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationX(pi),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(widget.vocabulary.color),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(2, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.vocabulary.define,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20.sp,
                  color: Color(widget.vocabulary.textColor)),
            ),
            Visibility(
              visible: widget.vocabulary.example == "" ? false : true,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.example}: ${widget.vocabulary.example}",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontStyle: FontStyle.italic,
                          color: Color(widget.vocabulary.textColor)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
