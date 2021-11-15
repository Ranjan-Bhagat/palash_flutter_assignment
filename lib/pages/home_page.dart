import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/pages/feed_page.dart';
import '/services/storage_service.dart';
import '/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final query = TextEditingController();
  final storage = StorageService();

  List<String>? searchHistory;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0)).then((_) async {
      await getHistory();
    });
    super.initState();
  }

  @override
  void dispose() {
    query.dispose();
    super.dispose();
  }

  getHistory() async {
    var history = await storage.getHistory();
    setState(() {
      searchHistory = history;
    });
  }

  void search(String query) async {
    if (query.isNotEmpty) {
      FocusScope.of(context).unfocus();
      await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FeedPage(query: query)));
      await storage.addHistory(query);
      await getHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plash flutter assignment'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: query,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: "Search Term",
                      ),
                      onSubmitted: (query) => search(query),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      label: 'SEARCH',
                      onPressed: () => search(query.text),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (searchHistory != null)
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 30,
                    children: searchHistory!
                        .map(
                          (e) => CustomButton(
                              label: e,
                              onPressed: () {
                                query.text = e;
                                search(e);
                              }),
                        )
                        .toList())
            ],
          ),
        ));
  }
}
