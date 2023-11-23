import 'package:flutter/material.dart';
import 'package:monolithia/constants/color.dart';
import 'package:monolithia/models/post_model.dart';
import 'package:monolithia/screens/second_screen.dart';
import 'package:monolithia/services/api_services.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<PostModel> postData = [];
  CustomColors customColors = CustomColors();
  final service = ApiService();
  getPost() async {
    try {
      final data = await service.fetchPosts();
      setState(() {
        postData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: postData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : ListView.builder(
              itemCount: postData.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondScreen(
                                    userId: postData[index].userId!,
                                    id: postData[index].id!,
                                    title: postData[index].title!,
                                    white2: CustomColors.white2,
                                  )));
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: CustomColors.white2,
                      title: Text('${postData[index].title}'),
                      subtitle: Text('${postData[index].body}'),
                      trailing: IconButton(
                          onPressed: () {
                            service.deletePost(postData[index].id!);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
