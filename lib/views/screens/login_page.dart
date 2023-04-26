import 'package:createnote_signin_signup_firebase/helper/firebase_auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9eeff),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                painter: MyPainter(),
                child: const SizedBox(
                  height: 200,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "Login",
                      style: GoogleFonts.rokkitt(
                        textStyle: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Form(
                      key: signInKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35, bottom: 15),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Your Email First...";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                email = val;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple, width: 1),
                                ),
                                hintText: "Enter Email Here...",
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Your Password First...";
                              } else if (val.length <= 6) {
                                return "Enter More Than 6 Letters......";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              password = val;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 1),
                              ),
                              hintText: "Enter Password Here...",
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            if (signInKey.currentState!.validate()) {
                              signInKey.currentState!.save();

                              Map<String, dynamic> data =
                                  await FirebaseAuthHelper.firebaseAuthHelper
                                      .logIn(
                                          email: email!, password: password!);

                              if (data['user'] != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Sign In Successfully....."),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );

                                Navigator.of(context)
                                    .pushReplacementNamed('/', arguments: data);
                              } else if (data['msg'] != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(data['msg']),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Sign In Failed....."),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }

                              emailController.clear();
                              passwordController.clear();

                              setState(() {
                                email = null;
                                password = null;
                              });
                            }
                          },
                          child: Container(
                            height: 65,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xffb790dc),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 9,
                                  offset: const Offset(0, 3),
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Expanded(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "LOGIN",
                                    style: GoogleFonts.rokkitt(
                                      textStyle: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Does not have account? ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: validateSignUp,
                          child: Text(
                            "SIGN UP",
                            style: GoogleFonts.rokkitt(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> data = await FirebaseAuthHelper
                              .firebaseAuthHelper
                              .logInAnonymously();

                          if (data['user'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Successfully...."),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            Navigator.of(context)
                                .pushReplacementNamed('/', arguments: data);
                          } else if (data['msg'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(data['msg']),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Logging Failed....."),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 65,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "GUEST LOGIN",
                            style: GoogleFonts.rokkitt(
                              textStyle: const TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> data = await FirebaseAuthHelper
                            .firebaseAuthHelper
                            .googleLogin();

                        if (data['user'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login Successfully...."),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.of(context)
                              .pushReplacementNamed('/', arguments: data);
                        } else if (data['msg'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(data['msg']),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Logging Failed....."),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 65,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 8,
                              color: Color(0xffb790dc),
                              offset: Offset(3, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/google_logo.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "GOOGLE LOGIN",
                                style: GoogleFonts.rokkitt(
                                  textStyle: const TextStyle(
                                    fontSize: 27,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validateSignUp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Sign Up Form"),
        ),
        content: Form(
          key: signUpKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Your Email First...";
                  }
                  return null;
                },
                onSaved: (val) {
                  email = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter Email here...",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                textInputAction: TextInputAction.done,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Your Password First...";
                  } else if (val.length <= 6) {
                    return "Enter More Than 6 Letters......";
                  }
                  return null;
                },
                onSaved: (val) {
                  password = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter Password here...",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            child: const Text("Sign Up"),
            onPressed: () async {
              if (signUpKey.currentState!.validate()) {
                signUpKey.currentState!.save();

                Map<String, dynamic> data = await FirebaseAuthHelper
                    .firebaseAuthHelper
                    .signUp(email: email!, password: password!);

                if (data['user'] != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("SignUp Successfully....."),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if (data['msg'] != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(data['msg']),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Sign Up Failed....."),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }

                emailController.clear();
                passwordController.clear();

                setState(() {
                  email = null;
                  password = null;
                });

                Navigator.pop(context);
              }
            },
          ),
          OutlinedButton(
            child: const Text("Cancel"),
            onPressed: () {
              emailController.clear();
              passwordController.clear();

              setState(() {
                email = null;
                password = null;
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint();

    brush.color = const Color(0xffb790dc);
    brush.style = PaintingStyle.fill;

    Path path = Path();

    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, size.height, 0, size.height);
    path.close();

    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
