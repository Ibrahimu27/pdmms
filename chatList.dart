import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class chatList extends StatefulWidget {
  const chatList({Key? key}) : super(key: key);

  @override
  _chatListState createState() => _chatListState();
}

class _chatListState extends State<chatList> {
  //API to pull list of names from the database
  static Future<List<Doctors>> chatListPull() async{
    var url = 'http://192.168.43.130/pdmms/doctorList.php';
    final response = await http.post(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<Doctors>(Doctors.fromJson).toList();
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<List<Doctors>>(
          future: chatListPull(),
          builder: (context, snapshot) {
            final convos = snapshot.data;

            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              default:
                if(snapshot.hasError){
                  return Text("oops! :( something went wrong");
                }else
                  if(snapshot.hasData){
                    return buildList(convos!);
                  }
            }
            return Text("Chats Loading...");
          },
        )
      ]
    );
  }

  Widget buildList(List<Doctors> convos) =>
        ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: convos.length,                        //add and implement the list of doctors the user can send messages to
        itemBuilder:(BuildContext context, int index){
          final chat = convos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: Text(chat.doctorName),

          );

        });

}

class Doctors{
  final String doctorName;
  final String doctorId;
  final String doctorPic;

  const Doctors({required this.doctorId, required this.doctorName, required this.doctorPic});

  static Doctors fromJson(json) =>Doctors(
     doctorName: json['doctorName'],
     doctorId: json['doctorName'],
     doctorPic: json['doctorPic']
  );
}
