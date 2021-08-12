import 'package:flutter/material.dart';
import 'package:prooxyy_events/helpers/helpers.dart';

// -- Rating
import 'package:prooxyy_events/models/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment rating;

  CommentWidget({
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage(rating.avatar),
        ),
        Text(
          rating.ratedBy,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50.0,
          width: 250.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.star,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              Icon(
                rating.value > 1.49 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              Icon(
                rating.value > 2.49 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              Icon(
                rating.value > 3.49 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              Icon(
                rating.value > 4.49 ? Icons.star : Icons.star_border,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
            ],
          ),
        ),
        vBox20(),
        Container(
          width: 500,
          child: Text(
            rating.comment,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
          ),
        ),
        vBox20(),
        Container(
          width: 500,
          child: Text(
            rating.category.toUpperCase(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
