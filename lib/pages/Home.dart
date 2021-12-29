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
  List<ListItem> dropdownItem = ListItem.getListItem();
  late List<DropdownMenuItem<ListItem>> dropdownMenuItem;
  late ListItem _selectedItem;

  List selectedSubject = [];

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    subjects = Subject.getSubject();
    dropdownMenuItem = createDropdownMenu(dropdownItem);
    _selectedItem = dropdownMenuItem[0].value!;

  }

  List<DropdownMenuItem<ListItem>> createDropdownMenu(
    List<ListItem> dropdownItem) {
      List<DropdownMenuItem<ListItem>> items = [];

      for (var item in dropdownItem) {
        items.add(DropdownMenuItem(
          child: Text(item.name!),
          value: item,
          
          )
        ); 
      }

    return items;
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
                  const SizedBox(height: 14),
                  DropdownButton(
                    value: _selectedItem,
                    items: dropdownMenuItem, 
                    onChanged: (value) {
                      setState(() {
                         _selectedItem = value as ListItem;
                      });
                    },
                  ),
                  Text('Item selected: ' + 
                    _selectedItem.value!.toString() + ' ' +
                    _selectedItem.name!),
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
class ListItem{
  int? value;
  String? name;

  ListItem(this.value, this.name);
  
  static List<ListItem> getListItem() {
    return[
      ListItem(1,'Item 1'),
      ListItem(2,'Item 2'),
      ListItem(3,'Item 3'),
      ListItem(4,'Item 4'),
    ];
  }
}