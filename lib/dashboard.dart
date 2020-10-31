import 'package:activepoint_frontend/customWidget/button/secondaryButton.dart';
import 'package:activepoint_frontend/model/takenTask.dart';
import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:activepoint_frontend/taskView.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<Dashboard> {


  String token = "";
  int takenTask = 0;
  int unfinishedTask = 0;

  @override
  Widget build(BuildContext context) {

    Column buildInfo(int countTasks, String title){
        return Column(
          children: [
            Text(
            countTasks.toString(),
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Color(0xffffffff)
              ),
            ),
            Text(
            title,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: Color(0xffffffff)
            ),
          )
        ]
      );
    };

    setState(() {
      _readToken().then((value) => {
        token = value,
      }).whenComplete(() => {
        requestTakenTask(token).then((value) => {
          takenTask = value.taken,
          unfinishedTask = value.unfinished,
        }),
      });
    });
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Text(
                      "Jobs\nDashboard",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: Color(0xff000000)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  LinearProgressIndicator(
                    value: takenTask == 0 ? 0 :  (unfinishedTask - takenTask) / takenTask,
                    backgroundColor: lightGrayColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Profile Completeness",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff8d8d8d)
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 15
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: secondaryColor
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildInfo(takenTask, "Taken Task"),
                  SizedBox(width: 25,),
                  buildInfo(unfinishedTask, "Unfinished Task")
                ],
              )
            ),
            SizedBox(height: 10,),
            Text("Available Task",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Color(0xff0000000)
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: TaskView(),
            )
          ],
        ),
      )
    );
  }
}

Future<String> _readToken() async {

  String _token = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _token = prefs.getString("REQUEST_TOKEN");

  return _token;
}

Future<TakenTask> requestTakenTask(String token) async{

  TaskHTTP taskHTTP = new TaskHTTP();

  int taken = 0;
  int unfinished = 0;

  await taskHTTP.getTakenTask(token).then((value) => {
    taken = value.taken,
    unfinished = value.unfinished,
  }).catchError((e) => print("error"));

  return new TakenTask(taken: taken, unfinished: unfinished);
}



