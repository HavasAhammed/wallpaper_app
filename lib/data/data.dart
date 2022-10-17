import 'package:wallpaper_hub/model/categories_model.dart';

String apiKey = '563492ad6f9170000100000194a944f205cc47c7a3dda9e9b699246b';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/street_art3.jpg';
  categoriesModel.categoriesName = 'Street Art';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();


  categoriesModel.imageUrl = 'images/wild_life.jpg';
  categoriesModel.categoriesName = 'Wild Life';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/nature.jpg';
  categoriesModel.categoriesName = 'Nature';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/city.jpg';
  categoriesModel.categoriesName = 'City';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/motivation.jpg';
  categoriesModel.categoriesName = 'Motivation';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/bikes.jpg';
  categoriesModel.categoriesName = 'Bikes';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imageUrl = 'images/cars.jpg';
  categoriesModel.categoriesName = 'Cars';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
