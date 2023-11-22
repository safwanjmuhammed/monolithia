import 'package:flutter/material.dart';
import 'package:monolithia/constants/color.dart';

class SecondScreen extends StatefulWidget {
  final int id;
  final String title;
  final Color white3;
  const SecondScreen(
      {super.key, required this.id, required this.title, required this.white3});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: widget.white3, borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Id'), Text('${widget.id}')],
                  ),
                ),
                Text('Title'),
                Flexible(child: Text('${widget.title}')),
                Expanded(
                  child: ListView.builder(itemBuilder: (context, int index) {
                    return Text('dmeo');
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
