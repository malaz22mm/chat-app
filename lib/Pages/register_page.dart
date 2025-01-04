import 'package:chatapp/Pages/chat_page.dart';
import 'package:chatapp/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/showSncak.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading=false;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Form(
          key:formKey ,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Image.asset("assets/images/scholar.png"),
              const Text(
                "Chat APP",
                style: TextStyle(
                    fontSize: 32, color: Colors.white, fontFamily: 'pacifico'),
              ),
              const Spacer(
                flex: 1,
              ),
              const Text("Sign Up",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                hintText: "Email",
                obscureText:false,
                onchange: (data) {
                  email = data;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  hintText: "Password",
                  obscureText:true,
                  onchange: (data) {
                    password = data;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    isLoading=true;
                    setState(() {

                    });
                    try {
                          await registerUser();
                          showSnackBar(context, "Email Created");
                          Navigator.pushNamed(context, ChatPage.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(context,"The password provided is too weak.");
                      } else if (e.code == 'email-already-in-use') {
                       showSnackBar(context, "Email already exists");
                      }
                    } catch (e) {
                     showSnackBar(context, "$e");
                    }
                    isLoading=false;
                    setState(() {
                      
                    });

                  }
                },
                text: "Sign Up",
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "if you have an account ?  ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,);
  }


}
