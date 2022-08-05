import 'dart:convert';

import 'package:http/http.dart';

import '../model/post_model.dart';

class Network{

  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String,String> headers = {'Content-type': 'application/json; charset=UTF-8',};

  /* Http Apis */
  static String API_LIST = "/posts";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/";//{id}
  static String API_DELETE = "/posts/";//{id}

  /* Http Requests */

  //GET
  static Future<String?> GET(String api, Map<String,String> params) async{
    var url = Uri.https(BASE,api, params);
    var response = await get(url, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  //POST
  static Future<String?> POST(String api, Map<String,String> params) async{
    var url = Uri.https(BASE, api);
    var response = await post(url, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200 || response.statusCode == 201){
      return response.body;
    }
    return null;
  }

  //PUT
  static Future<String?> PUT(String api, Map<String,String> params) async{
    var url = Uri.https(BASE, api);
    var response = await put(url,headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  //DEL
  static Future DEL(String api, Map<String,String> params) async{
    var url = Uri.https(BASE, api, params);
    var response = await delete(url, headers: headers,);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty(){
    Map<String, String> params = new Map();
    return params;
  }

  static Map<String,String> paramsCreate(Post post){
    Map<String,String> params = new Map();
    params.addAll({
      'title': post.title.toString(),
      'body': post.body.toString(),
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String,String> paramsUpdate(Post post){
    Map<String,String> params = new Map();
    params.addAll({
      'id' : post.id.toString(),
      'title': post.title.toString(),
      'body': post.body.toString(),
      'userId': post.userId.toString(),
    });
    return params;
  }

  static List<Post> parsePostList(String resp){
    dynamic json = jsonDecode(resp);
    var data = List<Post>.from(json.map((x)=>Post.fromJson(x)));
    return data;
  }

}