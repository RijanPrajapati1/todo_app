import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class form_screen extends StatefulWidget {
  static const routeName="/form";
  const form_screen({super.key});

  @override
  State<form_screen> createState() => _form_screenState();
}

class _form_screenState extends State<form_screen> {
  final TextEditingController fname=TextEditingController();
  final TextEditingController lname=TextEditingController();
  final TextEditingController contact=TextEditingController();
  final TextEditingController address=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController editemail=TextEditingController();



  final database =FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(stream: database.ref('details').onValue,
                builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }else if(snapshot.data!.snapshot.value==null){
                return const Text("No data available");
              }
                  print(snapshot.data!.snapshot.value);
                  print(snapshot.data!.snapshot.value.runtimeType);
                  Map<dynamic,dynamic> _datas=snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> value=_datas.values.toList();
                  List<dynamic> key=_datas.keys.toList();
                  return ListView.builder(
                    itemCount: value.length, //for loop
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed:(){
                                setState(() {
                                  editemail.text=value[index]['email'].toString();
                                });
                               showDialog(context: context,
                                   builder: (context) => AlertDialog(
                                     title: Text("Edit Data"),
                                     content: Container(
                                       height: 300,
                                       child: Column(
                                         children: [
                                           TextFormField(controller: editemail,),
                                           ElevatedButton(onPressed: () async{
                                             var datas={
                                               "email":editemail.text
                                             };
                                             await database
                                             .ref()
                                             .child('details')
                                             .child(key[index]).update(datas);
                                             Navigator.of(context).pop();
                                           }, child: Text("update"))
                                         ],
                                       ),
                                     ),
                                   ),);
                              },
                              icon: Icon(
                                Icons.edit,
                                color:Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                database.ref().child('details').child(key[index]).remove();
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        title: Text(value[index]['email'].toString()),
                      );
                    },
                  );
            }
            ),


            TextFormField(controller: fname,decoration: InputDecoration(label: Text("first name"))),
            TextFormField(controller: lname,decoration: InputDecoration(label: Text("last name"))),
            TextFormField(controller: contact,decoration: InputDecoration(label: Text("contact"))),
            TextFormField(controller: address,decoration: InputDecoration(label: Text("address"))),
            TextFormField(controller: email,decoration: InputDecoration(label: Text("email"))),


          ElevatedButton(onPressed: (){
            var datas={
              "firstname":fname.text,
              "lastname":lname.text,
              "contact":contact.text,
              "address":address.text,
              "email":email.text,
            };
            database.ref().child("details").push().set(datas);
          }, child:Text("submit"))



          ],
        ),
      ),
    );
  }
}
