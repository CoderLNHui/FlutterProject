# Flutter 实现百姓生活 Lift+

使用 flutter 仿写 百姓生活Lift+ ，内部涉及 flutter 常用组件的使用示例和规范。
主要模块有：商城首页、商品分类、商品详情、购物车、个人中心等，
主要用到的技术有：dio进行网络请求、fluro进行路由跳转、url_launcher进行打电话、shared_preferences进行数据存储、flutter_screenutil进行屏幕适配、Provide进行跨组件通信、flutter_html进行html的加载、flutter_easyrefresh进行列表的刷新等。

## 示例图

![FlutterProject](https://cdn.jsdelivr.net/gh/SunHui-Candy/Simg@tc/22img/FlutterProject.gif)


## Widget 

Flutter的理念是**万物皆Widget**（Everything is Widget），
这是为了实现Flutter的一个设计理念：**激进式组合（Aggressive composability）**。
Widget由一系列的小的Widget组合而成，而这些进行组合的Widget，本身是由更基础的Widget构成。

Widget的定义是：**描述一个UI元素的配置数据。它并不是表示最终绘制在设备上的显示元素，而只是描述显示元素的一个配置数据**。
Widget主要分为三类：**Component Widget(*组合类Widget*)、Proxy Widget(*代理类Widget*)以及Render Widget(*渲染类Widget*)**，
其中只有Render Widget才会参与后面的布局（layout）和渲染（paint）流程。

- **Widget是Element的配置数据，Element才真正代表屏幕显示元素；**
- **一个Widget对象可以对应多个Element对象。**

## Element 

- 维护Element Tree，根据Widget Tree的变化来更新Element Tree，
包括：节点的插入、更新、删除、移动等；
并起到纽带的作用，**将Widget以及RenderObject关联到Element Tree上**。
- Element分为**ComponentElement（组合类Element）和RenderObjectElement（渲染类Element）**，
 前者负责组合子Element，后者负责渲染。

**Element有4种状态：initial(*初始状态*)，active(*激活状态*)，inactive(*未激活状态*)，defunct(*失效状态*)**

## RenderObject 

- RenderObject主要**负责绘制**`paint`，**布局**`layout`，**命中测试**`hitTest`等。
- RenderObject**布局的原则是，Constraints向下，Sizes向上，父节点设置本节点的位置**。
- RenderView是整个RenderObject Tree的根节点，其child是一个 **RenderBox 类型的RenderObject**。

## Platform Channel

Flutter是通过Platform Channel同宿主平台进行通信的。
为了保证界面能够响应及时，消息的传递是异步的。
Flutter定义了三种不同类型的Platform Channel，它们分别是：
- **BasicMessageChannel：用于传递字符串和半结构化的信息。支持数据双向传递，有返回值**。
- **MethodChannel：用于传递方法调用（method invocation）。支持数据双向传递，有返回值**。
- **EventChannel: 用于数据流/(事件流)（event streams）的通信，仅支持数据单向传递（从Platform 平台 到Flutter），无返回值**。

## Provide进行跨组件通信

在使用Provider的时候，我们主要关心三个概念：
   >ChangeNotifier：真正数据（状态）存放的地方
    ChangeNotifierProvider：Widget树中提供数据（状态）的地方，会在其中创建对应的ChangeNotifier
    Consumer：Widget树中需要使用数据（状态）的地方
    
``` Swift
void main() {
  //启动Flutter应用,runApp接受一个Widget参数，在本示例中它是一个MyApp对象，MyApp()是Flutter应用的根组件
  var currentIndexProvide = CurrentIndexProvider();

  //flutter_provide 状态管理
  var providers = Providers();
  providers
   ..provide(Provider<CurrentIndexProvider>.value(currentIndexProvide))

 //ProviderNode封装了InheritWidget，并且提供了 一个providers容器用于放置状态。
  runApp(ProviderNode(child: MyApp(),providers: providers));
}

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvider> (
      builder: (context,child,val) {
        //获取状态currentIndex
        // int currentIndex = val.currentIndex; 或者使用以下方式获取 currentIndex
        int currentIndex = Provide.value<CurrentIndexProvider>(context).currentIndex;
        //Scaffold 是 Material 库中提供的页面脚手架，
        //它提供了默认的导航栏、标题和包含主屏幕widget树（后同“组件树”或“部件树”）的body属性，组件树可以很复杂
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245 ,1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              //更改状态currentIndex
              Provide.value<CurrentIndexProvider>(context).changeIndex(index);
            },
          ),
        //body的组件树中包含了一个Center 组件，Center 可以将其子组件树对齐到屏幕中心
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      }
    );
  }

/* 作用：监听点击tabbar时，下标的改变*/
 //ChangeNotifier，意思是可以不用管理听众
class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    print('点击的值');
    print(newIndex);
    //通过notifyListeners可以通知听众刷新。
    notifyListeners();
  }

}

```

## Flutter 进行网络请求实现

``` Swift

Future request(url,{formData})async
{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    if(formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url],data:formData);
    }
    print("查看响应数据请求url:${servicePath[url]},\n返回数据：${response.data}");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('有异常。。。');
    }
    
  }catch(e){
    return print('ERROR:======>$e');
  }

}

```