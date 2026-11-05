import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../widgets/avatar.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chat;

  const ChatScreen({
    super.key,
    required this.chat,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller =
      TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'message': 'Halo, apa kabar?',
      'time': '15:10',
      'isMe': false,
    },
    {
      'message': 'Baik, kamu bagaimana?',
      'time': '15:11',
      'isMe': true,
    },
    {
      'message': 'Baik juga 👍',
      'time': '15:12',
      'isMe': false,
    },
    {
      'message': 'Besok jadi meeting?',
      'time': '16:20',
      'isMe': false,
    },
  ];

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'message': text,
        'time': 'Now',
        'isMe': true,
      });
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008069),
        foregroundColor: Colors.white,

        titleSpacing: 0,

        title: Row(
          children: [
            Avatar(
              imageUrl: widget.chat.avatar,
              size: 40,
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  'online',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),

          PopupMenuButton<String>(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'contact',
                child: Text('Contact info'),
              ),
              PopupMenuItem(
                value: 'search',
                child: Text('Search'),
              ),
            ],
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECE5DD),
        ),

        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return MessageBubble(
                    message: message['message'],
                    time: message['time'],
                    isMe: message['isMe'],
                  );
                },
              ),
            ),

            _buildInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
            ),
          ),

          Expanded(
            child: TextField(
              controller: controller,
              textInputAction:
                  TextInputAction.send,
              onSubmitted: (_) => sendMessage(),

              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.attach_file,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 5),

          CircleAvatar(
            backgroundColor:
                const Color(0xFF00A884),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
