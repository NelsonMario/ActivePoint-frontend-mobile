import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

class RewardPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyRewardPageState();
  }
}

class _MyRewardPageState extends State<RewardPage>{


  @override
  Widget build(BuildContext context) {

    double windowWidth = MediaQuery.of(context).size.height;
    double windowHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Center(
        child: Text("Reward"),
      ),
    );
  }


}