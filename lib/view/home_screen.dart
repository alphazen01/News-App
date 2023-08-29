import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_chanel_headlines_model.dart';
import 'package:news/view/categoris_screen.dart';
import 'package:news/view/news_details.dart';
import 'package:news/view_model/news_view_model.dart';

import '../models/categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList {bbcNews, aryNews, independent, reuters, cnn, alJazeera}

class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedItem;

  final formate = DateFormat("MMM dd, yyyy");

  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>CategoriesScreen()));
          }, 
          icon: Image.asset(
          "assets/images/category_icon.png",
          height: 30,
          width: 30,
          ),
          ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedItem,
            icon: Icon(Icons.more_vert,color: Colors.black,),
            onSelected: (FilterList item){
              if (FilterList.bbcNews.name == item.name) {
                name = "bbc-news";
                
              }
              if (FilterList.aryNews.name == item.name) {
                name = "ary-news";
               
              }
              if (FilterList.independent.name == item.name) {
                name = "independent";
                
              }
              if (FilterList.alJazeera.name == item.name) {
                name = "al-jazeera-english";
               
              }
              if (FilterList.cnn.name == item.name) {
                name = "cnn";
                
              }
              if (FilterList.reuters.name == item.name) {
                name = "reuters";
               
              }
              setState(() {
                selectedItem = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text("BBC News")
                ),
                PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text("Ary News")
                ),
                PopupMenuItem<FilterList>(
                value: FilterList.independent,
                child: Text("Independent News")
                ),
                PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text("Al-Jazeera News")
                ),
                PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text("CNN News")
                ),
                PopupMenuItem<FilterList>(
                value: FilterList.reuters,
                child: Text("Reuters News")
                ),
            ]
            )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //Slider part
            Container(
              height: height*0.55,
              width: width,
              child: FutureBuilder<NewsChanelHeadlinesModel>(
                future: newsViewModel.fetchNewsChanelHeadlinesApi(name),
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
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString(),);
                        return
                         Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.6,
                            width: width*0.5,
                            child: InkWell(
                              onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (_)=>NewsDetailsScreen(id:snapshot.data!.articles![index])));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context,url)=>Container(child: spinkit2,),
                                  errorWidget: (context, url, error) =>Icon(Icons.error_outline,color: Colors.red,),
                                  ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container( 
                                alignment: Alignment.bottomCenter,
                                height: height*0.22,
                                width:width*0.45,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:width*0.5,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                      snapshot.data!.articles![index].title.toString(),
                                       maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700
                                      ),
                                      ),
                          
                                    ),
                                    Spacer(),
                                    Container(
                                      width:width*0.5,
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                          snapshot.data!.articles![index].source!.name.toString(),
                                           maxLines: 2,
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
                          
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                
                      ),
                    );
                      })
                      );
                  }
                }
                ),
            ),
            //NewsList Part
            Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder<CategoriesNewsModel>(
                    future: newsViewModel.fetchCategoriesNewsApi("general"),
                    builder: (context, snapshot,) {
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index, ) {
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString(),);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                onTap: (){
                            //        Navigator.push(context, 
                            //  MaterialPageRoute(builder: (_){
                               
                            //    return NewsDetailsScreen(id:newsViewModel.fetchCategoriesNewsApi(category)
                            //  );
                            //  }));
                                },
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
                                              Expanded(
                                                child: Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color:Colors.blue
                                                ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                formate.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
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
const spinkit2=SpinKitCircle(
  color: Colors.amber,
  size: 50,
 );
  