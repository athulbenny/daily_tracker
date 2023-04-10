import 'package:daily_tracker/tar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home:MyTracker(),
    debugShowCheckedModeBanner: false, ));
}

class MyTracker extends StatefulWidget {
  const MyTracker({Key? key}) : super(key: key);

  @override
  State<MyTracker> createState() => _MyTrackerState();
}

class _MyTrackerState extends State<MyTracker> {
  TextEditingController track = TextEditingController();
  List<String> li = [];int i=0;
  List<Widget> wi = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black38,
      appBar: AppBar(
        title: Text('Daily Target'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: wi.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            background: Container(
              color: Colors.green,
            ),
            key: ValueKey<Widget>(wi[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                wi.removeAt(index);
              });
            },
            child: wi[index]
          );
        },
      ),


       floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (ctx) {
              return AlertDialog(
                title: Text("enter item"),
                content:TextFormField(
                  controller: track,
                ),
                actions: [
                  TextButton(onPressed: () {
                    setState(() {
                     wi.add( Container(
                       height: 50,
                       color: Colors.blue[700],
                         padding: EdgeInsets.all(8),
                         child: Center(child: Text(track.text))),
                     );
                    });
                    track.clear();
                    Navigator.of(context).pop();
                  },
                      child: Text('add item')),
                ],
              );});
            //fun2();
            },child: Icon(Icons.add),
            ),
   //   ),
    );
  }
}

 // List<Widget> fun() {
 //   setState(() {
 //     //for (String title in li) {
 //       //wi.add(Text(title));
 //     if(i!=0) {
 //       wi.add(Dismissible(
 //         child: Container(
 //           child: ListTile(
 //             leading: Text(li[i]),
 //           ),
 //           padding: EdgeInsets.all(4),
 //           color: Colors.blue[200],
 //         ),
 //         key: ValueKey<Widget>(wi[i]),
 //         onDismissed: (DismissDirection direction){
 //           setState(() {
 //             wi.removeAt(i);
 //           });
 //         },
 //       ),);
 //       // }
 //     }
 //   });
 //   return wi;
 //  }


// Future fun2() async{
//   return showDialog(context: context, builder: (ctx) {
//     return AlertDialog(
//       title: Text("enter item"),
//       content: Text("www"),
//       actions: [
//         TextButton(onPressed: () {
//           li.add(track.text);
//           Navigator.of(context).pop();
//         },
//             child: Text('add item')),
//       ],
//     );});
// }


