import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatBotScreen extends StatefulWidget {
  ChatBotScreen({super.key, required this.user});
  String user;

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Message> _messages = [];

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages.add(Message(
        text: "Hi, I am the Urban Guide. How may I assist you?", isMe: false));
  }

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);

    if (message.text.isEmpty) return;

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, message);
    });

    String response = await getResponse(message.text);
    Message bot = Message(text: response, isMe: false);

    setState(() {
      _messages.insert(0, bot);
    });
  }

  Future<String> getResponse(String message) async {
    String apiUrl = 'http://127.0.0.1:5000/api?input=$message';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['response'];
    } else {
      throw Exception('Failed to load response');
    }
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'Bot',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color for the sender label
              ),
            ),
            const SizedBox(height: 5), // Adjust spacing as needed
            Container(
              decoration: BoxDecoration(
                color: message.isMe
                    ? const Color(0xFF21222D)
                    : const Color(0xFFA9DF21), // Change colors as desired
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                message.text,
                style: const TextStyle(
                  fontSize: 18,
                  // Adjust the font size as desired
                  color: Colors.white, // Text color for the message
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   if (index == 0) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => Dashboard(
  //                 user: '',
  //               )),
  //     );
  //   } else if (index == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Communities()),
  //     );
  //   } else if (index == 2) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const ChatBotScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        backgroundColor: const Color(0xFF21222D),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      hintText: 'Type a Message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onSendMessage,
                  icon: const Icon(
                    Icons.send,
                    size: 35, // Adjust the icon size as desired
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: _onItemTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: Color(0xFF21222D),
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.group,
      //         color: Color(0xFF21222D),
      //       ),
      //       label: 'Community',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.chat,
      //         color: Color(0xFF21222D),
      //       ),
      //       label: 'Chat Bot',
      //     ),
      //   ],
      // ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
