import 'package:flutter/material.dart';

class LoginPAge extends StatefulWidget {
  const LoginPAge({super.key});

  @override
  State<LoginPAge> createState() => _LoginPAgeState();
}

class _LoginPAgeState extends State<LoginPAge> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 30,
                offset: Offset(0, 5),
              ),

              BoxShadow(
                color: Colors.red,
                blurRadius: 10,
                offset: Offset(5, 0),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Here", style: TextStyle(fontSize: 30)),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: "Enter your name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Enter your Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter your Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock,color: Colors.white,),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.white,),

                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String name=nameController.text.trim();
                  String email=emailController.text.trim();
                  String password=passwordController.text.trim();

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(name))
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.red.shade900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
