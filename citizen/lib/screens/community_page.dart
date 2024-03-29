import 'package:citizen/screens/profile.dart';
import 'package:flutter/material.dart';
import '../chatbot/chatbot_screen.dart';
import 'user_dashboard.dart';

class Communities extends StatefulWidget {
  Communities({super.key, required this.user});
  String user;

  @override
  State<Communities> createState() => CommunitiesState();
}

class PostState {
  int selectedLike = 0;
  int selectedDislike = 0;
  String comment = "";
}

class CommunitiesState extends State<Communities> {
  List<PostState> postStates = List.generate(2, (index) => PostState());

  int selectedLike = 0;
  int selectedDislike = 0;
  String comment = "";

  void onDownvote(int index) {
    setState(() {
      postStates[index].selectedLike = 0;
      postStates[index].selectedDislike = 1;
    });
  }

  void onUpvote(int index) {
    setState(() {
      postStates[index].selectedLike = 1;
      postStates[index].selectedDislike = 0;
    });
  }

  void onComment(int index, String value) {
    setState(() {
      postStates[index].comment = value;
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  user: widget.user,
                )),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Communities(
                  user: widget.user,
                )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatBotScreen(user: widget.user)),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(
                  user: widget.user,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21222D),
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        //color: const Color.fromARGB(238, 238, 238, 238),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF21222D),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(45, 0),
                    bottomLeft: Radius.circular(45),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Community",
                        style: TextStyle(
                            fontSize: 35,
                            //fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.italic,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 8, top: 6, bottom: 6),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            //controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MyPostUI(
                img: "images/ppp.jpg",
                name: "Manya Singh",
                postID: "#127",
                content:
                    "Experiencing frequent power cuts in my area. Urgently need assistance to address the issue.",
                likes: 20,
                selectedLike: postStates[0].selectedLike,
                selectedDislike: postStates[0].selectedDislike,
                onUpvote: () => onUpvote(0),
                onDownvote: () => onDownvote(0),
                comment: postStates[0].comment,
                onComment: (value) => onComment(0, value),
              ),
              MyPostUI(
                img: "images/pfp.jpeg",
                name: "Harshita Arora",
                postID: "#337",
                content:
                    "Waterlogging is severe in my neighborhood, affecting daily life. Requesting immediate attention to resolve the issue",
                likes: 50,
                selectedLike: postStates[1].selectedLike,
                selectedDislike: postStates[1].selectedDislike,
                onUpvote: () => onUpvote(1),
                onDownvote: () => onDownvote(1),
                comment: postStates[1].comment,
                onComment: (value) => onComment(1, value),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
              color: Color(0xFF21222D),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              size: 30,
              color: Color(0xFF21222D),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 30,
              color: Color(0xFF21222D),
            ),
            label: 'Chat Bot',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xFF21222D),
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class MyPostUI extends StatelessWidget {
  final String img;
  final String name;
  final String postID;
  final String content;
  final int likes;
  final int selectedLike;
  final int selectedDislike;
  final Function() onUpvote;
  final Function() onDownvote;
  final String comment;
  final Function(String) onComment;
  //TextEditingController _textEditingController = TextEditingController();

  const MyPostUI({
    super.key,
    required this.img,
    required this.name,
    required this.postID,
    required this.content,
    required this.likes,
    required this.selectedLike,
    required this.selectedDislike,
    required this.onUpvote,
    required this.onDownvote,
    required this.comment,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage(img), // Replace with your image path
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      "12th Oct",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  postID,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      AssetImage('images/user1.jpeg'), // Liked user 1 image
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      AssetImage('images/user2.jpeg'), // Liked user 2 image
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage:
                      AssetImage('images/user3.jpeg'), // Liked user 3 image
                ),
                const SizedBox(width: 5),
                Text(
                  "+${likes - 3} likes",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.thumb_up_outlined,
                    color: selectedLike == 1 ? Colors.green : Colors.black,
                  ),
                  onPressed: onUpvote,
                ),
                IconButton(
                  icon: Icon(
                    Icons.thumb_down_outlined,
                    color: selectedDislike == 1 ? Colors.red : Colors.black,
                  ),
                  onPressed: onDownvote,
                ),
              ],
            ),
            const Divider(
              color: Color.fromARGB(255, 114, 113, 113),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    //controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Add your views here...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 2),
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) {
                      onComment(value);
                    },
                    maxLines: null, // Allow the text to wrap to the next line
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    //_textEditingController.clear();
                    onComment("");
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
