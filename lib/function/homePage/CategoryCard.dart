import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/controller/newsController.dart';

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;
  Map<String,String> convert={
    'Business':'商业',
    'Entertainment':'娱乐',
    'General':'推荐',
    'Health':'健康',
    'Science':'科学',
    'Sports':'运动',
    "Technology":'技术',
};
  CategoryCard({required this.imageAssetUrl, required this.categoryName});
  final _logic=Get.put(newsController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _logic.setType(categoryName);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                convert[categoryName]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}