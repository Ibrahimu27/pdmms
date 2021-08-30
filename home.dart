import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:medicalreminder/chatPage.dart';
import 'package:medicalreminder/loginPage.dart';

class MyApp2 extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'eg panadol',
      //description: 'adherence manager',
      // location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      // androidParams: AndroidParams(
      //   emailInvites: ["test@example.com"],
      // ),
      recurrence: recurrence,
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PDMMS'),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Add Medical Name'),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
            ),
            Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 1 remove this '),
            //   subtitle: const Text("weekly for 3 months"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.weekly,
            //         endDate: DateTime.now().add(Duration(days: 60)),
            //       ),
            //     ));
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 2'),
            //   subtitle: const Text("every 2 months for 6 times (1 year)"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.monthly,
            //         interval: 2,
            //         ocurrences: 6,
            //       ),
            //     ));
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 3'),
            //   subtitle:
            //       const Text("RRULE (android only) every year for 10 years"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.yearly,
            //         rRule: 'FREQ=YEARLY;COUNT=10;WKST=SU',
            //       ),
            //     ));
            //   },
            // ),
            Divider(),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF073558)),
                child: Column(
                  children:<Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/person.jpg'),
                    ),
                    Divider(),
                    Text(
                  "Activities Point",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),])
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                title: Text(
                  "Add medicine",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp2()),
                  );
                },
              ),

              Divider(),
              ListTile(
                leading: Icon(
                  Icons.featured_play_list_outlined,
                  color: Colors.green,
                ),
                title: Text(
                  "My doctor help",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  //getDetails();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatDetailPage()),
                  );
                },
              ),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }
}
