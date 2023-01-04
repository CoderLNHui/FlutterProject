import 'package:dio/dio.dart';
import '../config/service_url.dart';

Future request(url,{formData})async
{
  try{
    print('开始请求数据');
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