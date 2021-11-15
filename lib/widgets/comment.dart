import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment(
      {Key? key,
      required this.comment,
      this.userName = 'User Name',
      this.radius = 20.0})
      : super(key: key);

  final double radius;
  final String comment;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person, size: radius*1.5,),
        radius: radius,
      ),
      subtitle: Text(comment),
      title: Text(userName),
    );
  }
}
