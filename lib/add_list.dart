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
              label: const Text("Pin List"),
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
                  color: Colors.black54,
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
          Expanded(
            child: ListView(
              children: [
                CheckboxListTile(
                  title: TextField(
                    decoration: const InputDecoration(
                      hintText: "To-Do",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      decoration: isChecked!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: isChecked,
                  onChanged: (newBool) {
                    setState(() {
                      isChecked = newBool;
                      const TextStyle(
                        decoration: TextDecoration.lineThrough
                      );
                    });
                  },
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {},
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            textStyle: WidgetStatePropertyAll(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            fixedSize: WidgetStatePropertyAll(Size(350, 50))),
        child: const Text("Add List"),
      ),
    );
  }
}
