import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prooxyy_events/models/rating.dart';
import 'package:prooxyy_events/services/rating.dart';
import 'package:prooxyy_events/widgets/comment_widget.dart';
import 'package:provider/provider.dart';

class CommentBloc extends StatefulWidget {
  @override
  _CommentBlocState createState() => _CommentBlocState();
}

class _CommentBlocState extends State<CommentBloc> {
  List<Rating> _list = [];
  int _count = 10;
  int _index = 0;
  bool _didChange = false;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      --_count;
      if (_count < 0) {
        setState(() {
          _count = 10;
          _index = (_index + 1) % _list.length;
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {

    if (!_didChange) {
      _list = [...Provider.of<RatingService>(context).items];
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _index = (_index + -1) % _list.length;
              });
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Colors.grey[800]!,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios, // Icons.arrow_back_ios_new,
                  size: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          CommentWidget(
            rating: _list[_index],
          ),
          InkWell(
            onTap: () {
              setState(() {
                _index = (_index + 1) % _list.length;
              });
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Colors.grey[800]!,
                ),
              ),
              // padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
