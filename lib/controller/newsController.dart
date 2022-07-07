import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plack/component/Net/News.dart';

import '../models/News.dart';

class newsController extends GetxController{
  var _type="娱乐";
  Map<String,int> page={
    '金融':1,
    '娱乐':1,
    '世界':1,
    '健康':1,
    '科学':1,
    '运动':1,
    '技术':1,
    '军事':1,
    '汽车':1,
    '时尚':1,
    '游戏':1,
    '文化':1,
  };
  Map<String,List<News>> newslist={
    '金融':List.filled(1, getTemplate()),
    '娱乐':List.filled(1, getTemplate()),
    '世界':List.filled(1, getTemplate()),
    '军事':List.filled(1, getTemplate()),
    '健康':List.filled(1, getTemplate()),
    '科学':List.filled(1, getTemplate()),
    '运动':List.filled(1, getTemplate()),
    '技术':List.filled(1, getTemplate()),
    '汽车':List.filled(1, getTemplate()),
    '时尚':List.filled(1, getTemplate()),
    '游戏':List.filled(1, getTemplate()),
    '文化':List.filled(1, getTemplate()),
  };
  Map<String,List<int>> userNewsList={
    '/xihuan':[],
    '/shoucang':[],
    '/liulan':[],
  };
  static String typeConvert(String type){
    if(type=='军事')
      return 'milite';
    else if(type=='金融')
      return 'finance';
    else if(type=='世界')
      return 'world';
    else if(type=='娱乐')
      return 'ent';
    else if(type=='技术')
      return 'tech';
    else if(type=='汽车')
      return 'auto';
    else if(type=='时尚')
      return 'fashion';
    else if(type=='游戏')
      return 'games';
    else if(type=='文化')
      return 'cul';
    else if(type=='健康')
      return 'health';
    else
      return type;
  }
  static String typeReConvert(String type){
    if(type=='milite')
      return '军事';
    else if(type=='finance')
      return '金融';
    else if(type=='world')
      return '世界';
    else if(type=='ent')
      return '娱乐';
    else if(type=='tech')
      return '技术';
    else if(type=='auto')
      return '汽车';
    else if(type=='fashion')
      return '时尚';
    else if(type=='games')
      return '游戏';
    else if(type=='cul')
      return '文化';
    else if(type=='health')
      return '健康';
    else if(type=='Health')
      return '健康';
    else
      return type;
  }

  late List<News> news=(List.generate(1, (index)=>getTemplate())).obs;
  void getNewsbyCategory(int pageindex){
    getNews(typeConvert(_type),pageindex).then((value) {
     if(value.length!=0)
       {
           news=value;
           newslist[_type]=news;
           page[_type]=page[_type]!+1;
       }
     else{
       news=newslist[_type]!;
     }
     print(news.first.newsType);
     update();
   });
  }
  @override
  void onInit(){
    getNewsbyCategory(page[_type]!);
    super.onInit();
  }
  Future<News> getSpeciedNews(int id) async {
      return await getNewByid(id);
  }
  Future<void> getNewsIdByUserId(int userId,String type) async {
    var value=await getNewsConnects(type, userId);
    if(value.length>0)
      userNewsList[type]=value;
  }
  void setType(String type){
    _type=type;
    getNewsbyCategory(page[type]!);
  }
  void setLove(int newsid,int userid){
    setLoveInfo(newsid, userid);
  }
  void setCollection(int newsid,int userid){
    setCollectionInfo(newsid, userid);
  }
  void setVisit(int newsid,int userid){
    setVisitInfo(newsid, userid);
  }
}