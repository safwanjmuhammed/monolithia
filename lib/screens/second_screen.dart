import 'package:flutter/material.dart';
import 'package:monolithia/models/comment_model.dart';
import 'package:monolithia/services/api_services.dart';

class SecondScreen extends StatefulWidget {
  final int id;
  final String title;
  final Color white2;
  const SecondScreen(
      {super.key, required this.id, required this.title, required this.white2});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  ApiService service = ApiService();
  List<CommentModel> commmentData = [];

  void getComments() async {
    final data = await service.fetchComment(widget.id);
    setState(() {
      commmentData = data;
      print(commmentData[0].body);
    });
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: widget.white2, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: const Icon(Icons.arrow_back),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(
                  height: 30,
                ),
                // IconButton(
                //     onPressed: () => Navigator.pop(context),
                //     icon: Icon(Icons.arrow_back)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Id', style: TextStyle(fontSize: 20)),
                    Text('${widget.id}')
                  ],
                ),
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 20),
                ),
                Flexible(child: Text('${widget.title}')),
                const Divider(
                  color: Color.fromARGB(255, 203, 202, 202),
                ),
                Expanded(
                    child: commmentData.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: commmentData.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 182, 105, 105),
                                          child: Text(commmentData[index]
                                              .name!
                                              .substring(0, 1)
                                              .toUpperCase()),
                                        ),
                                        const Padding(
                                            padding:
                                                EdgeInsets.only(right: 10)),
                                        Flexible(
                                          child: Text(
                                            commmentData[index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(commmentData[index].body!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic))
                                  ],
                                ),
                              );
                            }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
