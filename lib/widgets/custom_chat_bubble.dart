import 'package:chatapp/model/message.dart';
import 'package:flutter/material.dart';

import '../Pages/login_page.dart';
class ChatBubble extends StatelessWidget {
   ChatBubble({required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:EdgeInsets.only(left: 16,top: 24,bottom: 24,right: 32) ,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),

          ),
          color: primaryColor,

        ),
        child: Text(message.message,style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),),
      ),
    );
  }}
   class ChatBubbleFriend extends StatelessWidget {
   ChatBubbleFriend({required this.message});

   final Message message;
   @override
   Widget build(BuildContext context) {
   return Align(
   alignment: Alignment.centerRight,
   child: Container(
   padding:EdgeInsets.only(left: 16,top: 24,bottom: 24,right: 32) ,
   margin: EdgeInsets.all(12),
   decoration: BoxDecoration(
   borderRadius: BorderRadius.only(
   topLeft: Radius.circular(32),
   topRight: Radius.circular(32),
   bottomLeft: Radius.circular(32),

   ),
   color: Colors.cyanAccent,

   ),
   child: Text(message.message,style: TextStyle(
   color: Colors.white,
   fontSize: 20
   ),),
   ),
   );
   }
}


