import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/showSncak.dart';
import 'chat_page.dart';

const primaryColor =  Color(0xff2B475E);

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLoading=false;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold (
        backgroundColor: primaryColor,
        body: Form(
          key:formKey ,
          child: Column(
            children: [
              const Spacer(flex: 2,),
              Image.asset("assets/images/scholar.png"),
              const Text("Chat APP",style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'pacifico'
              ),
              ),
              const Spacer(flex: 1,),
              const Text("Sign in",style: TextStyle(
                fontSize: 24,
                color: Colors.white,)),
              const SizedBox(
                height: 15,
              ),
          CustomText(hintText:"Email",
              obscureText:false,
            onchange: (data){
              email=data;
            }),
              const SizedBox(
                height: 10,
              ),
              CustomText(hintText:"Password",
                  obscureText:true,
                  onchange: (data){
                    password=data;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: ()async{
                  if (formKey.currentState!.validate()) {
                    isLoading=true;
                    setState(() {

                    });
                    try {
                      await loginUser();
                      Navigator.pushNamed(context, ChatPage.id,arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(context, 'Wrong password provided for that user.');
                      }
                      else {
                        showSnackBar(context, "$e");
                      }
                    }
                    isLoading=false;
                    setState(() {

                    });
                  }
                },
                text: "Login",
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("if you don't have an account ?  ",style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,'RegisterPage')
                     ;
                    },
                    child: Text("Register",style: TextStyle(
                        color: Colors.cyanAccent
                    ),
                    ),
                  ),

                ],
              ),
              const Spacer(flex: 3,)

            ],
          ),
        ),
      ),
    );
  }
  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!
    );
  }

}
