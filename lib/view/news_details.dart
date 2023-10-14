import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/news_chanel_headlines_model.dart';
import '../view_model/news_view_model.dart';

class NewsDetailsScreen extends StatefulWidget {

 final String newsImage, newsTitle, newsDate, author,description, content,source;



   NewsDetailsScreen({
    Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,

   }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

 
final formate = DateFormat("MMM dd, yyyy");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.height*1;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.source),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(formate.format(dateTime)),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height*0.4,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.newsImage,
              fit: BoxFit.cover,
              placeholder: ((context, url) =>Center(child: CircularProgressIndicator()) ),
              ),
          ),
         Expanded(
           child: Transform.translate(
            offset: Offset(0, -5),
             child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  
                ),
                child: Column(
                  children: [
                    Text("Title : "+widget.newsTitle.toString()),
                    SizedBox(height: 30,),
                    Text("Description : "+widget.description.toString()),
                    
                  ],
                ),
              ),
           ),
         ),
        ],
      ),
    );
  }
}