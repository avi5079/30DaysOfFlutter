import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState?.validate() != false) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/login_image.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Welcome${name != "" ? ',' : ''}  $name",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            name = value;
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              hintText: "Enter Username",
                              labelText: "Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username cannot be empty";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              } else if (value.length < 6) {
                                return "Password should be atleast 6 characters";
                              }
                              return null;
                            })
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Material(
                  color: !changeButton ? Colors.deepOrange : Colors.green,
                  borderRadius: BorderRadius.circular(changeButton ? 20 : 8),
                  child: InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          width: changeButton ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: !changeButton
                              ? const Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                              : const Icon(Icons.done_rounded))),
                )
              ],
            ),
          ),
        ));
  }
}
