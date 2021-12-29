import 'package:flutter/material.dart';
import 'package:textformfield/models/food.dart';
import 'package:textformfield/models/subject.dart';

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
  late List<Subject> subjects;

  List selectedSubject = [];

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subjects = Subject.getSubject();
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
            padding: const EdgeInsets.all(20),
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


                  Text('Item Salected : $foodValue'),
                  const SizedBox(height: 14),
                  Column(
                    children:createSubjectCheckbox(),
                  ),
                  // CheckboxListTile(
                  //   value: mobileChk,
                  //   title: Text('Mobile App'),
                  //   onChanged: (value){
                  //     setState(() {
                  //       mobileChk = value;
                  //     });
                  //   },
                  // ),
                  // CheckboxListTile(
                  //   value: chatbotChk,
                  //   title: Text('chatbot'),
                  //   onChanged: (value){
                  //     setState(() {
                  //       chatbotChk = value;
                  //     });
                  //   },
                  // )
                    // RadioListTile<dynamic>(
                    //   title: Text(food.thName!),
                    //   subtitle:Text(food.enName!),
                    //   secondary: Text(food.price!.toString() + '฿'),
                    //   value: food.foodvalue,
                    //   groupValue: foodValue,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       foodValue = value!;
                    //       });
                  
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

  // List<Widget> createFoodRadio() {
  //   List<Widget> listRadioFood = [];
  //   for (var food in foods) {
  //     listRadioFood.add(
  //       RadioListTile<dynamic>(
  //           title: Text(food.thName!),
  //           subtitle:Text(food.enName!),
  //           secondary: Text(food.price!.toString() + '฿'),
  //           value: food.foodvalue,
  //           groupValue: foodValue,
  //           onChanged: (value) {
  //             setState(() {
  //               foodValue = value!;
  //             });
  //           },
  //       ),
  //     );
  //   }
  //   return listRadioFood;
  // }

List<Widget> createFoodRadio(){
  List<Widget> listRadioFood = [];
  // list [] index 0,1,2,3 ['watcharin','rojaranumas']
  // dict {} key, value => {'name':'watcharin','surname':'rojaranumas'}
  // set () no duplicated data(0,0,0,1,3,4,5) ===> (0,1,3,4,5)

  listRadioFood = foods
    .map(
      (food) => RadioListTile<dynamic>(
        title: Text(food.thName!),
        subtitle:Text(food.enName!),
        secondary: Text(food.price!.toString() + '฿'),
        value: food.foodvalue,
        groupValue: foodValue,
        onChanged: (value) {
          setState(() {
            foodValue = value!;
            });
        }
      ),
    )
  .toList();
  return listRadioFood;
  }

  List<Widget> createSubjectCheckbox() {
    List<Widget> listCheckboxSubject = [];
    for (var subject in subjects) {
      listCheckboxSubject.add(
        CheckboxListTile(
          title: Text(subject.subName!),
          subtitle:Text('credit : ${subject.credit}'),
          value: subject.checked,
          onChanged: (value) {
            setState(() {
              subject.checked = value!;
            });
            if (value!) {
              selectedSubject.add(subject.subName);

            }else {
              selectedSubject.remove(subject.subName);
            }
            print(selectedSubject);
          },
        ),
      );
    }
    return listCheckboxSubject;
  }
}