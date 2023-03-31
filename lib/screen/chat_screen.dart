import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gpt_chat/screen/chat_message.dart';
import 'package:chat_gpt_api/chat_gpt.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
//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
class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final token ="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";

  final chatGpt = ChatGPT.builder(
    token:
   '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', // generate token from https://beta.openai.com/account/api-keys
  );


  Future<void> sendMessage() async {
    ChatMessage chatMessage = ChatMessage(message: textEditingController.text, sender: "user");
    setState(() {
      _messages.insert(0, chatMessage);
    });
    await textCompletion();


  }

  Future<void> textCompletion() async {
    const prompt = "Explain Quantum Computing in simple terms";

    Completion? completion = await chatGpt.textCompletion(
      request: CompletionRequest(
        prompt: textEditingController.text,
        maxTokens: 256,
      ),
    );
    final botReply = completion?.choices?.map((e) => e.text).join("");
    ChatMessage chatMessage = ChatMessage(message: botReply??"", sender: "bot");
    setState(() {
      _messages.insert(0, chatMessage);
    });
    textEditingController.clear();

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  Widget _buildTextComposer(){
    return(
        Row(
          children: [
            Expanded(child: TextField(
              onSubmitted: (value) => sendMessage(),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
            ),
            IconButton(onPressed: ()=> sendMessage(), icon: Icon(Icons.send)),
          ],
        )
    ).px16();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("chat GPT app"),),
      body:SafeArea(
        child: Column(
          children: [
            Flexible(child: ListView.builder(
              padding: Vx.m8,
              reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context,index){
              return _messages[index];
            })),
            Container(
              decoration: BoxDecoration(color: context.cardColor),
              child: _buildTextComposer(),
            )
          ],
        ),
      )
    );
  }
}
