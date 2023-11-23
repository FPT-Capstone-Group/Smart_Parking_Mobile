import 'package:flutter/material.dart';
import 'package:parking_auto/controller/get_current_user.dart';
import 'package:parking_auto/model/user.dart';

class UserPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  //final String urlImage;

  const UserPage({
    Key? key,
    required this.firstName,
    required this.lastName,
    //required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("User Page" + firstName),
          centerTitle: true,
        ),
        body: const MyCustomForm(),
      );
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  GetUserController getUser = GetUserController();
  @override
  void initState() {
    super.initState();
    getUser.getUserData(context);
  }

  final _formKey = GlobalKey<FormState>();
  User user = User();
  

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Text('first name: '),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                getUser.getUserData(context);
              },
              child: const Text('Getdata'),
            ),
          ),
        ],
      ),
    );
  }
}
