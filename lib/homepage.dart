import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constant/cons.dart';
import 'package:newsapp/models/model.dart';
import 'package:newsapp/services/newsApiService.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> newslist = [];
  var currentIndex;
  @override
  void didChangeDependencies() async {
    newslist = await NewsApiService().fetchNewsData();
    setState(() {});
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "News App",
          style: GoogleFonts.aladin(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  child: Text(
                    'All News',
                    style: myStyle(18, Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (currentIndex > 1) {
                            setState(() {
                              currentIndex = currentIndex - 1;
                            });
                          }
                        },
                        child: const Text('Prev'),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index + 1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                width: 25,
                                alignment: Alignment.center,
                                color: currentIndex == index + 1
                                    ? Colors.blue
                                    : Colors.white,
                                child: Text('${index + 1}'),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (currentIndex < 5) {
                            setState(() {
                              currentIndex = currentIndex + 1;
                            });
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Select One',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: ListView.separated(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newslist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height / 6,
                              decoration: const BoxDecoration(
                                  color: Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38, blurRadius: 15)
                                  ]),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${newslist[index].urlToImage}"),
                                                fit: BoxFit.cover)),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${newslist[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          maxLines: 2,
                                          style: myStyle(16, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          "${newslist[index].author}",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          maxLines: 2,
                                          style: myStyle(12, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          "${newslist[index].publishedAt}",
                                          textAlign: TextAlign.right,
                                          maxLines: 1,
                                          style: myStyle(
                                            8,
                                            Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Positioned(
                              child: Container(
                            height: 10,
                            width: 80,
                            color: const Color(0xff759fb9),
                          )),
                          Positioned(
                              child: Container(
                            height: 80,
                            width: 10,
                            color: const Color(0xff759fb9),
                          )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 80,
                                color: const Color(0xff759fb9),
                              )),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 80,
                                width: 10,
                                color: const Color(0xff759fb9),
                              )),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
