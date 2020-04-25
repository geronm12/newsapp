import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_modes.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '3e59475b32ad449ba96c6251d11b2cfe';

class NewsService with ChangeNotifier{

List<Article> headlines = [];

String _selectedCategory = 'business';

List<Category> categories = [
 Category(FontAwesomeIcons.building, 'business'),
 Category(FontAwesomeIcons.tv, 'entertainment'),
 Category(FontAwesomeIcons.addressCard, 'general'),
 Category(FontAwesomeIcons.headSideVirus, 'health'),
 Category(FontAwesomeIcons.vials, 'science'),
 Category(FontAwesomeIcons.volleyballBall, 'sports'),
 Category(FontAwesomeIcons.memory, 'techology')
];


Map<String,List<Article>>  categoryArticles = {};


NewsService(){
this.getTopHeadLines();

categories.forEach((item){

this.categoryArticles[item.name] = new List();

});

}

get selectedCategory => this._selectedCategory;

set selectedCategory(String valor) {

this._selectedCategory  = valor;

this.getArticlesByCategory(valor);

notifyListeners();

}


List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

getTopHeadLines() async {

final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar';

final resp = await http.get(url);

final newsResponse = newsResponseFromJson(resp.body); 

this.headlines.addAll(newsResponse.articles);
notifyListeners();
}




getArticlesByCategory(String category) async{

if(this.categoryArticles[category].length > 0){
  return this.categoryArticles[category];
}


final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ar&category=$category';

final resp = await http.get(url);

final newsResponse = newsResponseFromJson(resp.body); 


this.categoryArticles[category].addAll(newsResponse.articles);

print(this.categoryArticles);

notifyListeners();

}



}