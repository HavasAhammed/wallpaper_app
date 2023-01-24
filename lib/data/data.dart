import 'package:wallpaper_hub/model/categories_model.dart';

String apiKey = '563492ad6f9170000100000194a944f205cc47c7a3dda9e9b699246b';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = CategoriesModel();

  // street art

  categoriesModel.imageUrl = 'assets/street_art.jpg';
  categoriesModel.categoriesName = 'Street Art';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // wild life

  categoriesModel.imageUrl = 'assets/wild_life.jpg';
  categoriesModel.categoriesName = 'Wild Life';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // nature

  categoriesModel.imageUrl = 'assets/nature.jpg';
  categoriesModel.categoriesName = 'Nature';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // city

  categoriesModel.imageUrl = 'assets/city.jpg';
  categoriesModel.categoriesName = 'City';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // motivation

  categoriesModel.imageUrl = 'assets/motivation.jpg';
  categoriesModel.categoriesName = 'Motivation';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // bikes

  categoriesModel.imageUrl = 'assets/bikes.jpg';
  categoriesModel.categoriesName = 'Bikes';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  // cars

  categoriesModel.imageUrl = 'assets/cars.jpg';
  categoriesModel.categoriesName = 'Cars';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
