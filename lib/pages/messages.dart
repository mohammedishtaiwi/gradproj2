import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  final ImageProvider botAvatarImage;

  const MessagesScreen({
    Key? key,
    required this.messages,
    required this.botAvatarImage,
  }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return _currentUserId == null
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            itemBuilder: (context, index) {
              final isUserMessage = widget.messages[index]['isUserMessage'];
              final textColor = isUserMessage ? Colors.white : Colors.black;
              final messageText =
                  widget.messages[index]['message'].text.text[0];
              final avatarImage = isUserMessage ? null : widget.botAvatarImage;

              return Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: isUserMessage
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!isUserMessage) ...[
                      CircleAvatar(
                        backgroundImage: avatarImage,
                        radius: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Container(
                      constraints: BoxConstraints(
                        minWidth: 0,
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(40),
                          topRight: const Radius.circular(40),
                          bottomRight: Radius.circular(isUserMessage ? 0 : 40),
                          topLeft: Radius.circular(isUserMessage ? 40 : 0),
                        ),
                        color: isUserMessage ? Colors.blueGrey : Colors.grey,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      child: Text(
                        messageText,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    if (isUserMessage) ...[
                      const SizedBox(width: 8),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(_currentUserId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          final profilePictureUrl =
                              snapshot.data!['profileImageUrl'];
                          return CircleAvatar(
                            backgroundImage: NetworkImage(profilePictureUrl),
                            radius: 20,
                          );
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
            separatorBuilder: (_, i) =>
                const Padding(padding: EdgeInsets.only(top: 10)),
            itemCount: widget.messages.length,
          );
  }
}
