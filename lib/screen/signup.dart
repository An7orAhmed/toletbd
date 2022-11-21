import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toletbd/constants.dart';
import 'package:toletbd/model/user.dart';
import 'package:toletbd/utilities.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final repass = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final nid = TextEditingController();

  String type = "USER";
  bool isRenter = true;
  bool isAdmin = false;

  Future<void> _signup(context) async {
    if (email.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Please enter your email first!'));
      return;
    }
    if (pass.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Please enter your password!'));
      return;
    }
    if (pass.text != repass.text) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'Password not matched!'));
      return;
    }
    if (name.text.isEmpty || address.text.isEmpty || phone.text.isEmpty || nid.text.isEmpty) {
      scafKey.currentState!
          .showSnackBar(snackBar(Colors.amber, Colors.black, Icons.warning, 'There is a empty field!'));
      return;
    }

    try {
      scafKey.currentState!.showSnackBar(snackBar(Colors.black, Colors.white, Icons.error, 'Signing up...'));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
      var user = AppUser(
          name: name.text, email: email.text, address: address.text, phone: phone.text, nid: nid.text, type: type);
      await db.collection('User').doc(email.text).set(user.toMap());
      db.collection("User").doc(email.text).get().then((doc) async {
        currentUser = AppUser.fromMap(doc.data()!);
        currentUser.type == "ADMIN" ? isAdmin = true : isAdmin = false;
        await auth.signInWithEmailAndPassword(email: email.text, password: pass.text);
        Navigator.of(context).pushNamedAndRemoveUntil(isAdmin ? '/adminHome' : '/renterHome', (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, e.code));
    } catch (e) {
      scafKey.currentState!.showSnackBar(snackBar(Colors.red, Colors.white, Icons.error, 'Something wrong!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', scale: 3.0),
                      const SizedBox(width: 15),
                      Text(appName, style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: pass,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: repass,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Re-enter password',
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      prefixIcon: const Icon(Icons.home),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nid,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'NID Number',
                      prefixIcon: const Icon(Icons.badge),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Account Type: "),
                      ChoiceChip(
                        label: const Text("Renter"),
                        labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        selected: isRenter,
                        onSelected: ((value) => setState(() {
                              if (value == true) type = "USER";
                              isAdmin = false;
                              isRenter = !isRenter;
                            })),
                      ),
                      ChoiceChip(
                        label: const Text("Owner"),
                        labelPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        selected: isAdmin,
                        onSelected: ((value) => setState(() {
                              if (value == true) type = "ADMIN";
                              isRenter = false;
                              isAdmin = !isAdmin;
                            })),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => _signup(context),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text('Signup', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Already registered? login here'),
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
