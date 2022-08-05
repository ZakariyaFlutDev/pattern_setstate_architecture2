import 'package:flutter/material.dart';
import 'package:pattern_setstate_architecture2/model/post_model.dart';
import 'package:pattern_setstate_architecture2/pages/home_page.dart';
import 'package:pattern_setstate_architecture2/service/http_service.dart';
class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  static const String id = "create_post";

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void _apiCreatePost() async{
    setState(() {
      isLoading = true;
    });
    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();

    Post post =  Post(id: 101, title: title, body: content, userId: 101);

    var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    setState(() {

      if(response !=null){
        Navigator.pushNamed(context, HomePage.id);
      }else{
        return;
      }
      isLoading = false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post", style: TextStyle(color: Colors.white, fontSize: 28),),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300
                    ),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300
                    ),
                    child: TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                          hintText: "Content",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue
                    ),
                    child: Center(
                        child: GestureDetector(
                          onTap: (){
                            _apiCreatePost();
                            print("ADD");
                          },
                          child: Text("Add Post", style: TextStyle(color: Colors.white, fontSize: 22),),
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
        ],
      )
    );
  }
}
