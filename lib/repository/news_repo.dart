

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/categories_news_model.dart';
import 'package:news/models/news_chanel_headlines_model.dart';

class NewsRepository{

Future<NewsChanelHeadlinesModel>fetchNewsChanelHeadlinesApi(String channelName)async{
   String url ="https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=1949f9aa87e446faa5531f75712b3869";
 
  final response = await http.get(Uri.parse(url));
 if (response.statusCode==200) {
  
  final body=jsonDecode(response.body);
  
   return NewsChanelHeadlinesModel.fromJson(body);
 } 
   throw Exception("error");
 }

Future<CategoriesNewsModel>fetchCategoriesNewsApi(String category)async{
   String url ="https://newsapi.org/v2/everything?q=${category}&apiKey=1949f9aa87e446faa5531f75712b3869";
 
  final response = await http.get(Uri.parse(url));
 if (response.statusCode==200) {

  final body=jsonDecode(response.body);
  
   return CategoriesNewsModel.fromJson(body);
 } 
   throw Exception("error");
 }


}





