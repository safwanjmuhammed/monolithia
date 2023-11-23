import 'package:flutter/material.dart';
import 'package:monolithia/components/post_card.dart';
import 'package:monolithia/constants/color.dart';
import 'package:monolithia/models/user_model.dart';
import 'package:monolithia/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService service = ApiService();
  List<UserModel> userData = [];
  String? selectedValue = '';
  // CustomColors customColors = CustomColors();

  getUser() async {
    final data = await service.fetchUsers();
    setState(() {
      userData = data;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f9fa),
      body: SafeArea(
        child: Column(
          children: [
            Center(
                child: userData.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(color: Colors.black),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: CustomColors.white3,
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButton(
                              padding: const EdgeInsets.all(5),
                              dropdownColor: CustomColors.white2,
                              hint: selectedValue!.isEmpty
                                  ? const Text('Select user')
                                  : Text(selectedValue!),
                              items: List.generate(
                                  userData.length,
                                  (index) => DropdownMenuItem(
                                      value: userData[index].name,
                                      child: Text(userData[index].name!))),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              }),
                        ),
                      )),
            const PostCard(),
          ],
        ),
      ),
    );
  }
}
