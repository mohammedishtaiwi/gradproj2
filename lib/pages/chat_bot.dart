import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late DialogFlowtter dialogFlowtter;
  String selectedAvatar = "Chatbot";
  String selectedAvatarTitle = "Chatbot";

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  // Define avatar titles
  final List<String> avatarTitles = [
    "Sama",
    "Shatha",
    "Mohammed",
    "Shams",
    "Sewar"
  ];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "AI Avatar",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white, //this is the color of the background
        child: Column(
          children: [
            // Avatars section
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildAvatarTile(
                      title: "Sama", onTap: () => updateSelectedAvatar("Sama")),
                  buildAvatarTile(
                      title: "Shatha",
                      onTap: () => updateSelectedAvatar("Shatha")),
                  buildAvatarTile(
                      title: "Mohammed",
                      onTap: () => updateSelectedAvatar("Mohammed")),
                  buildAvatarTile(
                      title: "Shams",
                      onTap: () => updateSelectedAvatar("Shams")),
                  buildAvatarTile(
                      title: "Sewar",
                      onTap: () => updateSelectedAvatar("Sewar")),
                ],
              ),
            ),
            Expanded(
              child: MessagesScreen(
                messages: messages,
                botAvatarImage: getSelectedAvatarImage(selectedAvatar),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                          color: Colors
                              .black), // i Set text color to white so i can see whats written
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: const Color.fromARGB(255, 255, 255,
                            255), // the bubble thing where you type
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        hintText: 'Type Here...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAvatarTile({
    required String title,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
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

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  void updateSelectedAvatar(String avatar) {
    setState(() {
      selectedAvatar = avatar;
    });
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
