import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:daily_tracker/dailyModel.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(const MaterialApp(home:MyTracker(),
    debugShowCheckedModeBanner: false, ));
}

class MyTracker extends StatefulWidget {
  const MyTracker({Key? key}) : super(key: key);

  @override
  State<MyTracker> createState() => _MyTrackerState();
}

class _MyTrackerState extends State<MyTracker> {

  @override
  void initState() {
    super.initState();
    Hive.registerAdapter(DailyModelAdapter());
    _openBox();
    Timer.periodic(Duration(seconds: 1), (timer) { setState(() {

    });});
  }
  var dir;
  Future _openBox() async {
    dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    if (kDebugMode) {
      print(dir.path);
    }
    _dailyBox =
    await Hive.openBox('dailyTargetBox'); //Hive.box<DataModel>(dataBoxName);
    return;
  }
  Box? _dailyBox;

  TextEditingController track = TextEditingController();
  TextEditingController hr = TextEditingController();
  TextEditingController min = TextEditingController();

  List<int> hours=[];
  List<int> minutes=[];


  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    tracker();hours=[];minutes=[];
    return Scaffold(
      //backgroundColor:Colors.black38,
      appBar: AppBar(
        title: Text('Daily Target'),
        backgroundColor: Colors.orange,

      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          _dailyBox==null? const Text("no data"):
              Expanded(child: WatchBoxBuilder(box: _dailyBox!, builder: (context,box){
                Map<dynamic, dynamic> raw =box.toMap();
                List list = raw.values.toList();
                return Container(//padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                child: ListView.separated(
                itemCount: list.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DailyModel dailyModel = list[index];
                  hours.add(int.parse(dailyModel.alarm.split(':').first));
                  minutes.add(int.parse(dailyModel.alarm.split(':').last));

                  return Dismissible(
                    onDismissed: (DismissDirection direction){
                     _dailyBox?.deleteAt(index);
                     setState(() {

                     });
                    },
                    key: ValueKey<DailyModel>(list[index]),
                    child: Container(height: MediaQuery.of(context).size.height/15,
                      child: Card(color: Colors.grey,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${dailyModel.id}'),
                            Text('${dailyModel.content}',style: TextStyle(fontSize: 25),),
                            Text('${dailyModel.alarm}')
                          ],
                        ),
                      ),
                    ),
                  );
                },separatorBuilder: (context,index){
                  return Container(height: 10,);
                },
                ),);
              })),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (ctx) {
            track.text=""; hr.text="";min.text="";
            return AlertDialog(
              title: Text("Enter Item"),
              content:
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Content'
                    ),
                    controller: track,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,minLines: 1,
                  ),
                actions: [
                  Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width/3,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Hour'
                          ),
                          controller: hr,
                        ),
                      ),
                  Container(width: MediaQuery.of(context).size.width/3,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Minute'
                      ),
                      controller: min,
                    ),
                  ),
                    ],
                  ),
              //   ],
              // ),

                TextButton(onPressed: () {
                  String time= hr.text+ ":" +min.text;
                  DailyModel dailyModel = DailyModel(
                  _dailyBox!.toMap().length+1, track.text, time );
                  _dailyBox?.add(dailyModel);
                  track.clear();hr.clear();min.clear();
                  Navigator.of(context).pop();
                },
                    child: Text('Add item')),
              ],
            );});
          //fun2();
        },child: Icon(Icons.add),
      ),
      //   ),
    );
  }

  void tracker(){
    int n=hours.length;

    int valhr,valmin,timehr,timemin,fhr=0,fmin=0;

    for(int count=0;count<n;count++){
      timehr=DateTime.now().hour;
      if(hours[count]==timehr){
        fhr=1;
      }else {fhr=0;}
      timemin=DateTime.now().minute;
      if(minutes[count]==timemin){
        fmin=1;
      }else{fmin=0;}
      if(fhr==1 && fmin==1  ){
        Source path= AssetSource('Treasure.ogg');
        player.play(path);
        print("alarm rings");
        //sound[count]==1;
      }else{
        player.stop();
      }//else{print("alarm not set wait");}
    }
  }

}
