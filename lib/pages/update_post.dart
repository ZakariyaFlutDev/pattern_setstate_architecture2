import 'package:flutter/material.dart';
import 'package:pattern_setstate_architecture2/model/post_model.dart';
import 'package:pattern_setstate_architecture2/pages/home_page.dart';
import 'package:pattern_setstate_architecture2/service/http_service.dart';

class UpdatePost extends StatefulWidget {
  const UpdatePost({Key? key, required this.post}) : super(key: key);

  static const String id = "update_post";
  final Post post;

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.post.title!;
    contentController.text = widget.post.body!;
  }

  void _apiUpdatePost() async {
    setState(() {
      isLoading = true;
    });
    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();

    widget.post.title = title;
    widget.post.body = content;

    var response = await Network.PUT(
        Network.API_UPDATE + widget.post.id.toString(),
        Network.paramsUpdate(widget.post));

    setState(() {
      if (response != null) {
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        return;
      }
      isLoading = false;
    });

    print(widget.post.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Post",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
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
                          color: Colors.grey.shade300),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Title",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: widget.post.body!.length < 50 ? 50 : 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade300),
                      child: TextField(
                        maxLines: 20,
                        minLines: 2,
                        controller: contentController,
                        decoration: InputDecoration(
                            hintText: "Content",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 16),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      child: Center(
                          child: GestureDetector(
                        onTap: () {
                          _apiUpdatePost();
                        },
                        child: Text(
                          "Update Post",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      )),
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
        ));
  }
}
