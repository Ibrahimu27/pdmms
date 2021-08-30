import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'loginPage.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController sms = new TextEditingController();
  late Future<List<Messages>> messages;
  List<Messages> allMessages = [];

  //API to send texts to the database
  void senddata() async {
    log("status before sending");
    var data = {'name': sms.text};
    log("status after feeding data");
    final response =
    await http.post(Uri.parse('http://192.168.43.130/pdmms/sendMessages.php'), body:data);
    log("status after connection");
  }

  //API yo pull data from the database
  Future<List<Messages>> getDetails() async {
    log("status before connection");
    final response =
    await http.get(Uri.parse('http://192.168.43.130/pdmms/getMessages.php'));
    log("status after connection");
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    for (var data in items) {
      log("Received: " + data['DoctorReplies'].toString());
      var message = new Messages(
          ujumbe: data['Message'] ?? '',
          status: data['status'] ?? '',
          patientID: data['patientID']??'');
      allMessages.add(message);
      log("Message: " + message.ujumbe);
    }

    log("status after decoding");
    log(" returning data");
    return allMessages;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages = getDetails();
  }

  @override
  Widget build(BuildContext context) {
    log("widget called");
    return Scaffold(
        backgroundColor: Color(0xFF073558) ,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "My Doctor",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.deepPurple),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Say something",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Expanded(
                  child:FutureBuilder(
                      future: messages,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            log("checking for error");
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            List<Messages> ujumbe = snapshot.data;
                            log("displaying the called function");
                            return MessageView(ujumbe: ujumbe);
                          }
                        }
                        return Center(
                          child: Text("is loading"),
                        );
                      }
                  )
              ),
              Divider(),                                                             //................added............//
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.greenAccent,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(Icons.add, color: Colors.white, size: 20, ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: TextField(
                            controller: sms,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: (){
                            senddata();
                            sms.clear();
                            getDetails();
                            //clearing the field after sending text
                          },
                          child: Icon(Icons.send,color: Colors.white,size: 18,),
                          backgroundColor: Colors.green,
                          elevation: 0,
                        ),
                      ],

                    ),
                  ),
                ),
              )
            ] ) );
  }

  Widget MessageView({required List<Messages> ujumbe}) {
    log("called widget");
    return ListView.builder(
        itemCount: ujumbe.length,
        itemBuilder: (BuildContext context, int index) {
          Messages messages = ujumbe[index];
          return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(

                child: Container(
                  padding:
                  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages.status == "sent"   //here is the point to use statuses to arrange the messages
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages.status == "sent"  //change here too to change color/ differentiate colors
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                       messages.ujumbe,
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}

class Messages {
  late final String patientID;
  late final String ujumbe;
  late final String status;

  Messages(
      {required this.ujumbe,
        required this.patientID,
        required this.status});

}
