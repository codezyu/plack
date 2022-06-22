class CategoryModel{
  late String url;
  late String name;
  CategoryModel();
  CategoryModel.fromJson(Map<String, dynamic> json){
    name=json['name'].toString();
    url=json['url'].toString();
  }
}