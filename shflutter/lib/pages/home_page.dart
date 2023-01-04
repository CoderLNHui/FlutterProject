import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service/service_method.dart';
import 'dart:convert'; //json解析用
import '../routers/application.dart';
import '../model/category.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/current_index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  List<Map> hotGoodsList=[];

  @override
  Widget build(BuildContext context) {

    var formData = {'lon':'115.02932','lat':'35.76189'};
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      appBar: AppBar(title: Text('Lift+'),),
      body: FutureBuilder(
        future: request('homePageContext',formData: formData),
        builder: (context, snapshot) { 
            if(snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList = (data['data']['slides'] as List).cast();// 顶部轮播组件数
              List<Map> navigatorList = (data['data']['category'] as List).cast();//类别列表
              String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
              String  leaderImage= data['data']['shopInfo']['leaderImage'];  //店长图片
              String  leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话 
               List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
               String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
                List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
                List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片 
                

              return EasyRefresh(
                footer: MaterialFooter(
                
                ),
                child: ListView(
                  children: [
                    HomeSwiperDiy(swiperDataList: swiperDataList),
                    HomeTopNavigator(navigatorList: navigatorList),
                    HomeAdBanner(advertesPicture: advertesPicture),
                    HomeLeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone),
                    HomeRecommend(recommendList: recommendList),
                    HomeFloorTitle(picture_address:floor1Title),
                    HomeFloorContent(floorGoodsList:floor1),
                    HomeFloorTitle(picture_address:floor2Title),
                    HomeFloorContent(floorGoodsList:floor2),
                    HomeFloorTitle(picture_address:floor3Title),
                    HomeFloorContent(floorGoodsList:floor3),
                    _hotGoods(),
                  ],
                ),
                onLoad:() async {
                   print('开始加载更多');
                   var formPage = {'page':page};
                   await request('homePageBelowConten',formData:formPage).then((val){
                     var data = json.decode(val.toString());
                     List<Map> newGoodsList = (data['data']as List).cast();
                     setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                   });
                },

              );
            } else {
              return Center(
                child:Text('加载中'),
              );
            } 
        },
        
      ),
    );
  }

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5,color: Colors.black12)
      )
    ),
    child: Text('火爆专区'),
  );

  //火爆专区子项
  Widget _wrapList(){
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color:Colors.white,
            padding: EdgeInsets.all(5.0),
            margin:EdgeInsets.only(bottom:3.0),
            child: Column(
              children: [
                Image.network(val['image'],width: ScreenUtil().setWidth(3775)),
                Text(
                  val['name'], 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink, 
                    fontSize: ScreenUtil().setSp(26)
                  )
                ),
                Row(
                  children: [
                    Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough), 
                      )
                  ],
                )
              ],
            ),
          )
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('无数据');
    }
  }
  
  //火爆专区组合
  Widget _hotGoods(){

    return Container(
      child: Column(
        children: [
          hotTitle,
          _wrapList(),
        ],
      ),
    );

  }
}


//楼层商品组件
class HomeFloorContent extends StatelessWidget {
  final List floorGoodsList;
  HomeFloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }
  Widget _firstRow(context){
    return Row(
      children: [
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: [
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: [
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4])
      ],
    );
  }

  Widget _goodsItem(context,Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }


}

//楼层标题
class HomeFloorTitle extends StatelessWidget {
  final String picture_address;// 图片地址
  HomeFloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//商品推荐
class HomeRecommend extends StatelessWidget {
  final List recommendList;
  HomeRecommend({Key key,this.recommendList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(context)
        ],
      ),
    );
  }
 

  //推荐商品标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0,2.0,0.5,0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom:BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink)
      ),
    );
  }

 //列表
 Widget _recommedList(BuildContext context) {
   return Container(
     height: ScreenUtil().setHeight(380),
     child: ListView.builder(
       scrollDirection: Axis.horizontal,
       itemCount: recommendList.length,
       itemBuilder: (context,index){
         return _item(index,context);
       },
     ),
   );
 }

 Widget _item(index,context){
   return InkWell(
     onTap: (){
       Application.router.navigateTo(context,"/detail?id=${recommendList[index]['goodsId']}");
     },
     child: Container(
       width: ScreenUtil().setWidth(280),
       padding: EdgeInsets.all(8.0),
       decoration: BoxDecoration(
         color: Colors.white,
         border: Border(
           left: BorderSide(width: 0.5,color: Colors.black12),
         ),
       ),
       child: Column(
         children: [
           Image.network(recommendList[index]['image']),
           Text('￥${recommendList[index]['mallPrice']}'),
           Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough, //下划线
                color:Colors.grey
              ),
            )
         ],
       ),
     ),

   );
 }

}
//手机相关
class HomeLeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话
  HomeLeaderPhone({Key key,this.leaderImage,this.leaderPhone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: _launchUrl,
          child: Image.network(leaderImage),
      ),
    );
  }
  void _launchUrl() async {
    String url = 'tel:'+leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//广告图片
class HomeAdBanner extends StatelessWidget {
  final String advertesPicture;
  HomeAdBanner({Key key, this.advertesPicture}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(advertesPicture),
    );
  }
}

//首页导航组件
class HomeTopNavigator extends StatelessWidget {
  final List navigatorList;
  HomeTopNavigator({Key key, this.navigatorList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10,navigatorList.length);
    }
    var tempIndex = -1;
    return Container(
      color: Colors.green,
      margin: EdgeInsets.only(top:5.0),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navigatorList.map((item){
          tempIndex++;
          return _gridViewItemUI(context,item,tempIndex);
        }).toList(),

      ),      
    );
  }

  Widget _gridViewItemUI(BuildContext context, item, index){
    print('点击了-------${item}');
    return InkWell(
      onTap: (){
        _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  void _goCategory(context,int index, String categroyId)async {
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      List list = category.data;
      Provide.value<ChildCategory>(context).changeCategory(categroyId,index);
      Provide.value<ChildCategory>(context).getChildCategory(list[index].bxMallSubDto,categroyId);
      Provide.value<CurrentIndexProvider>(context).changeIndex(1);
    });

  }

  

}

//首页轮播组件编写
class HomeSwiperDiy extends StatelessWidget {

  final List swiperDataList;
  HomeSwiperDiy({Key key,this.swiperDataList}):super(key: key); 

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750), 
      height: ScreenUtil().setHeight(333), 
      child: Swiper(
          itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){
                Application.router.navigateTo(context,"/detail?id=${swiperDataList[index]['goodsId']}");
              },
              child: Image.network("${swiperDataList[index]['image']}",fit: BoxFit.fill),
            );
          },
          itemCount: swiperDataList.length,
          autoplay: true,
          pagination: new SwiperPagination(),
      ),
    );
  }
}

