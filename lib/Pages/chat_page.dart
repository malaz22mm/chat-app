import 'package:chatapp/Pages/login_page.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatPage extends StatelessWidget {

  static String id='ChatPage';

  String documentId= 'JYBhSaSzeshKuSioPJIF';

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

TextEditingController controller =TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return  StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt',descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message> messageList=[];
          for(int i=0; i<snapshot.data!.docs.length;i++)
            {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/scholar.png",height: 60,),
                  const Text('Malaz Chat ',style: TextStyle(
                      color: Colors.white
                  ),),
                ],
              ),
            ),
            body:Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder:(context,index){
                      return messageList[index].id==email ?
                        ChatBubble(message: messageList[index],)
                      :ChatBubbleFriend(message: messageList[index]) ;
                    } ,)

                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add({
                        'message': data,
                        'createdAt':DateTime.now(),
                        'id':email
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                        hintText: 'Send message',
                        suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: primaryColor,)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: primaryColor
                            )
                        )
                    ),
                  ),
                )

              ],
            )

        );}
        else {
          return const Scaffold(body: Center(child: Text('loading....')));
        }
      }
    );
  }
}
