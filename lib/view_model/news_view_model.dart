import 'package:news/models/categories_news_model.dart';
import 'package:news/models/news_chanel_headlines_model.dart';
import 'package:news/repository/news_repo.dart';

class NewsViewModel{


final  _repo = NewsRepository();

Future<NewsChanelHeadlinesModel>fetchNewsChanelHeadlinesApi(String channelName)async{

final response = await _repo.fetchNewsChanelHeadlinesApi(channelName);
return response;

}
Future<CategoriesNewsModel>fetchCategoriesNewsApi(String category)async{

final response = await _repo.fetchCategoriesNewsApi(category);
return response;

}

}