import 'package:flutter/material.dart';
import 'package:monolithia/constants/color.dart';
import 'package:monolithia/screens/first_screen.dart';
import 'package:monolithia/services/api_services.dart';

class ThirdScreen extends StatefulWidget {
  final int userId;
  final int id;
  const ThirdScreen({super.key, required this.userId, required this.id});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final service = ApiService();
  TextEditingController userIdController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController titleCController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  CustomColors colors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.white2,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkResponse(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                  myTextfield(titleCController, 'Title'),
                  myTextfield(bodyController, 'Post'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            try {
                              if (titleCController.text.isEmpty ||
                                  bodyController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Fields cannot be empty')));
                              } else {
                                service.createPost(widget.userId, widget.id,
                                    titleCController.text, bodyController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Post created successfully')));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: const Text(
                            'Add post',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget myTextfield(TextEditingController controller, String labeltxt) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labeltxt,
            focusedBorder: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder()),
      ),
    );
  }
}
