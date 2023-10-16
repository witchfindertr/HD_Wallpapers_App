import '../models/category.model.dart';

String apiKey = "01dV8NfN3Eve12VlKutbryGYulaFRbftOYYU5ev09mmG0JCSjD978reo";

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Minimal";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/4352247/pexels-photo-4352247.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Pastel";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/6044255/pexels-photo-6044255.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Nature";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/5850083/pexels-photo-5850083.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Dark";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/3494648/pexels-photo-3494648.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Street Art";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/162379/lost-places-pforphoto-leave-factory-162379.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "City";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1123972/pexels-photo-1123972.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Football";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1884574/pexels-photo-1884574.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Cars";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/13369577/pexels-photo-13369577.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Architecture";
  categories.add(categoryModel);
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/6766628/pexels-photo-6766628.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Aesthetic";
  categories.add(categoryModel);
  categoryModel.imgUrl =
  "https://images.pexels.com/photos/3910073/pexels-photo-3910073.jpeg?auto=compress&cs=tinysrgb&w=700&h=700&dpr=2";
  categoryModel = CategoryModel();

  return categories;
}
