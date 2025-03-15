import 'package:flutter/material.dart';

class Ex01 extends StatelessWidget {

  final List<String> text = <String>["Apple iPhone 12",
                                      "Samsung Galaxy S21",
                                      "Google Pixel 6",
                                      "OnePlus 9 Pro",
                                      "MacBook Air M2"];
  final List<String> subText = <String>["779.0",
                                        "779.0",
                                        "699.0",
                                        "729.0",
                                        "999.0"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("List view Exercise"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTitle("ListView"),
            buildListView(),

            buildTitle("ListView.builder"),
            buildListViewBuilder(),

            buildTitle("ListView.separated"),
            buildListViewSeparated(),
          ],
        ),
      ),
    );
  }
  Widget buildListView() {
    return Container(
      height: 250,
      child: ListView(
        padding: const EdgeInsets.all(3),
        children: List.generate(
            text.length,
            (index) => buildContainer(text[index], subText[index])),
      ),
    );
  }
  Widget buildListViewBuilder() {
    return Container(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.all(3),
        itemCount: text.length,
        itemBuilder: (BuildContext context, int index) {
          return buildContainer(text[index], subText[index]);
        },
      ) ,
    );
  }
  Widget buildListViewSeparated() {
    return Container(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.all(3),
        itemCount: text.length,
        itemBuilder: (BuildContext context, int index) {
          return buildContainer(text[index], subText[index]);
        },
        separatorBuilder: (BuildContext contex, int index) {
          return Divider(color: Colors.grey, thickness: 1);
        },
      ),
    );
  }
  Widget buildContainer(String text, String subText) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subText,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }
  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}