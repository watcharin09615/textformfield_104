import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key,required this.title }) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.title!),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  username(),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  password(),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  submit()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
TextFormField password() {
    return TextFormField(
      controller: _passwordcontroller,
        validator: (value){
          if (value!.isEmpty){
            return 'Enter Password';
          }
          return null;
        },
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.blue,
            )
          )
        ),
    );
  }

  ElevatedButton submit() {
    return ElevatedButton(
      onPressed: () {
        if(_formkey.currentState!.validate()){
          print(_usernamecontroller.text);
          print(_passwordcontroller.text);
          }
        return null;
      },
      child: Text('submit'),
    );
  }

  TextFormField username() {
    return TextFormField(
      controller: _usernamecontroller,
      validator: (value){
        if (value!.isEmpty){
          return 'Enter Username';
        }
        return null;
      },
      // obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Icons.person),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          )
        )
      ),
    );
  }
}