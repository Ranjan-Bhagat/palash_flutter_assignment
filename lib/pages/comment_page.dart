import 'package:flutter/material.dart';
import 'package:palash_flutter_assignment/widgets/comment.dart';

import '/services/speeh_to_text_service.dart';
import '/widgets/custom_button.dart';
import '/models/photo_model.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.photo}) : super(key: key);

  final PhotoModel photo;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = [];

  final commentController = TextEditingController();
  final scrollController = ScrollController();

  bool isListning = false;

  void comment() {
    //Mocking api if comment is not empty
    if (commentController.text.isNotEmpty) {
      setState(() {
        comments.add(Comment(comment: commentController.text));
      });
      commentController.text = '';
    }
  }

  void textToSpeech() {
    //Calling text to speech api
    SpeechToTextService.toggleRecording(onResult: (text) {
      setState(() {
        commentController.text =  text;
      });
    }, onListening: (isListning) { 
      setState(() {
        this.isListning = isListning;
      });
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          controller: scrollController,
          shrinkWrap: true,
          children: [
            SizedBox(
              child: Image.network(
                widget.photo.src.large2X,
                fit: BoxFit.cover,
              ),
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  primary: false,
                  itemCount: comments.length,
                  itemBuilder: (context, i) => comments[i],
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-110),
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            hintText: "Comment",
                          ),
                          onSubmitted: (_) => comment(),
                          onTap: () => scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                          label: "Comment",
                          onPressed: comment,
                      ),
                    ],
                  ),
                  CustomButton(
                      label:
                          isListning ? 'Listning...' : 'Voice to text comment',
                      color: isListning ? null : Colors.pink,
                      onPressed: textToSpeech)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
