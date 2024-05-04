import 'package:flutter/material.dart';
import 'responses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String selectedAvatarTitle = "Chatbot";
  String selectedAvatar = "Chatbot";
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        String displayName = userSnapshot.get('name') ?? "User";
        setState(() {
          _messages.add(ChatMessage(
            text: "Welcome back, $displayName!",
            sender: selectedAvatar,
          ));
        });
      } catch (e) {
        print("Error fetching user's display name: $e");
      }
    }
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    String response = _getResponseForMessage(text.toLowerCase());
    User? user = _auth.currentUser;
    String displayName = user != null ? user.displayName ?? "User" : "User";

    // Fetch user's display name from Firestore
    if (user != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        displayName = userSnapshot.get('name') ?? displayName;
      } catch (e) {
        print("Error fetching user's display name: $e");
      }
    }

    ChatMessage message = ChatMessage(
      text: text,
      sender: displayName,
    );
    setState(() {
      _messages.insert(0, message);
      if (response.isNotEmpty) {
        _messages.insert(
          0,
          ChatMessage(
            text: response,
            sender: selectedAvatar, // Use selectedAvatar as the sender
          ),
        );
      }
    });
  }

  String _getResponseForMessage(String message) {
    String bestResponse = "";

    // Initialize the maximum number of matches
    int maxMatches = 0;

    // Iterate over each entry in the responses map
    responses.forEach((query, response) {
      // Split the query into individual words
      List<String> words = query.split(':');

      // Get the string before the colon
      String queryPrefix = words.first.trim();

      // Check if the user message contains the query prefix
      if (message.toLowerCase().contains(queryPrefix.toLowerCase())) {
        // Calculate the number of matches
        int matches = queryPrefix
            .split(' ')
            .where((word) => message.toLowerCase().contains(word.toLowerCase()))
            .length;

        // If the current query has more matches, update the best response
        if (matches > maxMatches) {
          maxMatches = matches;
          bestResponse = response;
        }
      }
    });

    return bestResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat"),
      ),
      body: Column(
        children: <Widget>[
          // Avatars section
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAvatarTile(title: "Sama"),
                buildAvatarTile(title: "Shatha"),
                buildAvatarTile(title: "Mohammed"),
                buildAvatarTile(title: "Shams"),
                buildAvatarTile(title: "Sewar"),
              ],
            ),
          ),
          Divider(height: 1.0),
          // Chat messages section
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget buildAvatarTile({
    required String title,
  }) =>
      GestureDetector(
        onTap: () {
          setState(() {
            selectedAvatar = title; // Update selected avatar
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedAvatar == title
                        ? Color.fromARGB(255, 31, 120, 193)
                        : Colors.transparent,
                    width: 3.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: getSelectedAvatarImage(title),
                  foregroundColor: Colors.grey,
                  radius: 24,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.amberAccent),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;

  const ChatMessage({required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child:
                CircleAvatar(backgroundImage: getSelectedAvatarImage(sender)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sender,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

ImageProvider getSelectedAvatarImage(String title) {
  switch (title) {
    case 'Sama':
      return AssetImage('assets/samaz.jpeg');
    case 'Shatha':
      return AssetImage('assets/sha.jpeg');
    case 'Mohammed':
      return AssetImage('assets/moh.jpeg');
    case 'Shams':
      return AssetImage('assets/shams.jpeg');
    case 'Sewar':
      return AssetImage('assets/sewar.jpeg');

    default:
      return AssetImage('assets/default_profile_picture.png');
  }
}
