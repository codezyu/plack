import '../../models/CategoryModel.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = <CategoryModel>[];
  CategoryModel categoryModel;

  //1

  //2
  categoryModel = new CategoryModel();
  categoryModel.name = "娱乐";
  categoryModel.url = "https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categoryModel);
  //3
  categoryModel = new CategoryModel();
  categoryModel.name = "世界";
  categoryModel.url = "https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60";
  myCategories.add(categoryModel);
  //军事
  categoryModel = new CategoryModel();
  categoryModel.name = "军事";
  categoryModel.url = "https://images.unsplash.com/photo-1591672434057-1192298eefc1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8bWlsaXRhcnl8fHx8fHwxNjU3MTcxNTc1&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080";
  myCategories.add(categoryModel);
  //自动驾驶
  categoryModel = new CategoryModel();
  categoryModel.name = "汽车";
  categoryModel.url = "https://images.unsplash.com/photo-1614165936271-8c1ea97b4a13?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8YXV0b3x8fHx8fDE2NTcxNzMxOTk&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080";
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.name = "游戏";
  categoryModel.url =  "https://images.unsplash.com/photo-1580327344181-c1163234e5a0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Z2FtZXx8fHx8fDE2NTcxNzM4MTk&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080"  ;
  myCategories.add(categoryModel);
  //金融
  categoryModel = new CategoryModel();
  categoryModel.name = "金融";
  categoryModel.url = "https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80";
  myCategories.add(categoryModel);
  //时尚
  categoryModel = new CategoryModel();
  categoryModel.name = "时尚";
  categoryModel.url ="https://images.unsplash.com/photo-1576827471288-0a8f6d6c937b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8ZmFzaGlvbnx8fHx8fDE2NTcxNzM2MTM&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080" ;
  myCategories.add(categoryModel);
  //4
  categoryModel = new CategoryModel();
  categoryModel.name = "健康";
  categoryModel.url = "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  myCategories.add(categoryModel);

  // //5
  // categoryModel = new CategoryModel();
  // categoryModel.name = "科学";
  // categoryModel.url = "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  // myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.name = "文化";
  categoryModel.url = "https://images.unsplash.com/photo-1528372962917-5d0b57649c3d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8dHJhZGl0aW9uYWx8fHx8fHwxNjU3MTc0MzQy&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080";
  myCategories.add(categoryModel);
  //5
  // categoryModel = new CategoryModel();
  // categoryModel.name = "运动";
  // categoryModel.url = "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  // myCategories.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.name = "科技";
  categoryModel.url = "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categoryModel);

  return myCategories;
}