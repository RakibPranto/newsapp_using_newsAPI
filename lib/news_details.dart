import 'package:flutter/material.dart';
import 'package:newsapp/homepage.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatelessWidget {
  static String routeName = "newsDetails";
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var publishedAt = ModalRoute.of(context)!.settings.arguments as String;
    var currentData =
        Provider.of<NewsProvider>(context).findByDate(publishedAt);
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 250,
              leading: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(),
                      ));
                },
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
              title: Row(
                children: [
                  Column(
                    children: const [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Details',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(
                  "${currentData.urlToImage}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    "${currentData.title}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(color: Colors.black26, thickness: 2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Written by: ${currentData.author}\nDate:${currentData.publishedAt}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${currentData.description}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${currentData.content}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
