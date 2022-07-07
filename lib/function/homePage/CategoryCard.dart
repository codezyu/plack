import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plack/controller/newsController.dart';

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;
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
                height: 90,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                categoryName,
                semanticsLabel: '点击刷新'+categoryName+'新闻',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}