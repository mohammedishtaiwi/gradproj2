import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        final isUserMessage = widget.messages[index]['isUserMessage'];
        final textColor = isUserMessage ? Colors.white : Colors.black;
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(40),
                    topRight: const Radius.circular(40),
                    bottomRight: Radius.circular(isUserMessage ? 0 : 40),
                    topLeft: Radius.circular(isUserMessage ? 40 : 0),
                  ),
                  color: isUserMessage ? Colors.blueGrey : Colors.grey,
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(
                  widget.messages[index]['message'].text.text[0],
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
    );
  }
}
