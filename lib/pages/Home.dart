import 'package:flutter/material.dart';
import 'package:textformfield/models/food.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key,required this.title }) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String? foodValue;
  late List<Food> foods;

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.title),
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
                  const SizedBox(height: 14,),
                  password(),
                  const SizedBox(height: 14,),
                  // radi('pizza','59'),
                  // radi('steak','59'),
                  Column(
                    children: createFoodRadio(),
                  ),
                  submit()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
// RadioListTile radi(name , price){
//   return RadioListTile(
//     title: Text(name),
//     subtitle:Text(price),
//     value: name,
//     groupValue: foodValue,
//     onChanged: (value) {},
//   );
// }

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

  List<Widget> createFoodRadio() {
    List<Widget> listRadioFood = [];
    for (var food in foods) {
      listRadioFood.add(
        RadioListTile<dynamic>(
            title: Text(food.thName!),
            subtitle:Text(food.enName!),
            secondary: Text(food.price!.toString()),
            value: food.foodvalue,
            groupValue: foodValue,
            onChanged: (value) {
              setState(() {
                foodValue = value.toString();
              });
            },
        ),
      );
    }
    return listRadioFood;
  }
}