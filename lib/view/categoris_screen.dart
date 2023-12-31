import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/categories_news_model.dart';

import '../view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();


  final formate = DateFormat("MMM dd, yyyy");

  String categoryName = "general";


  List<String> categoriesList = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"
  ];






  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: (){
                      categoryName =categoriesList[index];
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color:categoryName == categoriesList[index]? Colors.blue:Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(
                          child: Text(
                            categoriesList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize:13,
                              color: Colors.white
                            ),
                        )
                        ),
                      ),
                    ),
                  );
                })
                ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState==ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return  ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: ((context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString(),);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                height: height*0.18,
                                width: width*0.2,
                                placeholder: (context,url)=>Container(child: Center(
                              child: SpinKitCircle(
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),),
                                errorWidget: (context, url, error) =>Icon(Icons.error_outline,color: Colors.red,),
                                ),
                            ),
                            Expanded(
                              child: Container(
                                height: height*0.18,
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                       snapshot.data!.articles![index].title.toString(),
                                       maxLines: 3,
                                       style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700
                                       ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                        snapshot.data!.articles![index].source!.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color:Colors.blue
                                        ),
                                        ),
                                        Text(
                                        formate.format(dateTime),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            ],
                          ),
                        );
                         
                      })
                      );
                  }
                }
                ),
            ),
          ],
        ),
      ),
    );
  }
}