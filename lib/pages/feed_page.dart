import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palash_flutter_assignment/models/photo_model.dart';

import '/models/search_photo_model.dart';
import '/pages/comment_page.dart';
import '/services/api_service.dart';

class FeedPage extends StatefulWidget {
  final String query;

  const FeedPage({Key? key, required this.query}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final scrollController = ScrollController();

  dynamic data;
  late List<PhotoModel> photos;

  bool loadingNewPage = false;

  @override
  void initState() {
    //when widget building is done this will run the given function
    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      //Getting data from api
      var _data = await ApiService.search(widget.query);

      setState(() {
        data = _data;
        if (data is SearchPhotoModel) {
          photos = data.photos;
        }
      });

      //Adding listener to scroll controller when ever scroll ends it will load
      //some more data if it can
      scrollController.addListener(() async {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange &&
            data.nextPage != null) {
          setState(() {
            loadingNewPage = true;
          });
          var nextPageData = await ApiService.searchNextPage((data.nextPage));
          if (nextPageData is SearchPhotoModel) {
            setState(() {
              loadingNewPage = false;
              data = nextPageData;
              photos += nextPageData.photos;
            });
          } else {
            setState(() {
              loadingNewPage = false;
            });
          }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    //Disposting scroll controller
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      if (data != null) {
        if (data is SearchPhotoModel) {
          if (data.totalResults == 0) {
            //When no data is avaliable
            return const Center(child: Text("No data found."));
          } else {
            //When data isloded show photos is grid view builder
            return Scrollbar(
              isAlwaysShown: true,
              controller: scrollController,
              child: ListView(controller: scrollController, children: [
                GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    CommentPage(photo: photos[index]))),
                        child: Image.network(
                          photos[index].src.medium,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                //when loading new photos it will show this
                if (loadingNewPage)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
              ]),
            );
          }
        } else {
          //If there an error then it will show this
          return const Center(
              child: Text("Somthing went wrong please try again later."));
        }
      }
      //when looding data it will show this
      return const Center(child: CircularProgressIndicator());
    }));
  }
}
