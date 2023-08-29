import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/news_chanel_headlines_model.dart';
import '../view_model/news_view_model.dart';

class NewsDetailsScreen extends StatefulWidget {

 final dynamic id;



   NewsDetailsScreen({
    Key? key,
    required this.id
   }) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

 
NewsViewModel newsViewModel = NewsViewModel();
String name = "bbc-news";


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height*1;
    final width = MediaQuery.of(context).size.height*1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
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
                                //Navigator.push(context, MaterialPageRoute(builder: (_)=>NewsDetailsScreen(img:snapshot.data!.articles![index].toString())));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context,url)=>Container(child: Text("data"),),
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
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.teal,
              ),
              Container(
                height:height ,
                width: double.infinity,
                color: Colors.blue,
              ),

            ],
          ),
        ),
      ),
    );
  }
}