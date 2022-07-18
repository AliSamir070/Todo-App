import 'package:flutter/material.dart';
import 'package:test_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscured = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                      controller: emailController,
                      text: "Email",
                      type: TextInputType.emailAddress,
                      Prefix: Icon(
                        Icons.email
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email must be entered";
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                      controller: passwordController,
                      text: "Password",
                      type: TextInputType.visiblePassword,
                      Prefix: Icon(
                          Icons.key
                      ),
                      Suffix: IconButton(
                          onPressed: (){
                            setState((){
                              isObscured = !isObscured;
                            });
                          },
                          icon: Icon(
                              isObscured ? Icons.visibility_off : Icons.visibility
                          )
                      ),
                      isObscured: isObscured,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Password must be entered";
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthenticationButton(
                      width: double.infinity,
                      onPressed: (){
                        if(formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      text: "login",
                      color:Colors.blue
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthenticationButton(
                      width: double.infinity,
                      onPressed: (){
                        print(emailController.text);
                        print(passwordController.text);
                      },
                      text: "ReGIster",
                      color:Colors.blue,
                      isUpper: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?"
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: (){},
                          child: Text(
                            'Register now'
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
