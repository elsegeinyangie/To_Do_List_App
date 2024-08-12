import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListStates();
}

class _AddListStates extends State<AddList> {
  bool _isPinnedPressed = false;

  void _handlePinnedPress() {
    setState(() {
      _isPinnedPressed = !_isPinnedPressed;
    });
  }

  final TextEditingController textEditingController = TextEditingController();
  String titleText = '';

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: _handlePinnedPress,
              label: const Text("Pinned"),
              icon: const FaIcon(
                FontAwesomeIcons.mapPin,
                size: 16.0,
              ),
              style: ButtonStyle(
                backgroundColor: _isPinnedPressed
                    ? const WidgetStatePropertyAll(Colors.black)
                    : const WidgetStatePropertyAll(Colors.white),
                foregroundColor: _isPinnedPressed
                    ? const WidgetStatePropertyAll(Colors.white)
                    : const WidgetStatePropertyAll(Colors.black),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.black,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.black,
              ),
              onSubmitted: (String value) {
                setState(() {
                  titleText = textEditingController.text;
                });
              },
              keyboardType: TextInputType.text,
            ),
          ),
          ListView(
            children: [
              CheckboxListTile(
                title: const Text("To do"),
                value: isChecked,
                onChanged: (newBool) {
                  setState(() {
                    isChecked = newBool;
                  });
                },
                activeColor: Colors.black,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
