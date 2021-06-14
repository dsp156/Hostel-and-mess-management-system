import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowRooms extends StatefulWidget {
  final String block, room;
  ShowRooms(this.block, this.room);
  @override
  _ShowRoomsState createState() => _ShowRoomsState(block, room);
}

class _ShowRoomsState extends State<ShowRooms> {
  final String block, room;
  _ShowRoomsState(this.block, this.room);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.block,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   GestureDetector(
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal:10.0),
        //       child: Icon(
        //         Icons.search,
        //       ),
        //     ),
        //     // onTap: ()=>showSearch(
        //     //   context: context,
        //     //   delegate: Datasearch(widget.type,),
        //     // ),
        //   )
        // ],
      ),
      backgroundColor: Colors.redAccent,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .doc(block)
            .collection(room)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )));
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  )),
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Text(
                "There are not any blogs to show",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return Container(
            color: Colors.black,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot student = snapshot.data.docs[index];
                print(block);
                print(student['Block']);
                return Card(
                  elevation: 10.0,
                  color: Colors.white,
                  child: ListTile(
                    title: Text('Enrollment No:' + student['Enrollment No']),
                    subtitle: Text('Block:' +
                        student['Block'] +
                        " " +
                        'Name:' +
                        student[
                            'name']), //snapshot data should dispaly in this text field
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// class Datasearch extends SearchDelegate<String>{
//   String type;
//   var _index;
//   Datasearch(this.type,this._index);

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return ThemeData(
//       backgroundColor: Colors.black,
//       iconTheme: IconThemeData(color: Colors.white),
//       primaryColor: Colors.white,
//     );
//   }
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       new IconButton
//       (
//         icon: Icon
//         (
//           Icons.clear
//         ),
//         onPressed: (){
//           query="";
//         }
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return
//       new IconButton(
//         icon: new AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: (){
//           close(context, null);
//         }
//       );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Streambuilder(query,type,_index);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var qry=query;
//     return Streambuilder(qry,type,_index);
//   }

// }

// ignore: must_be_immutable
// class Streambuilder extends StatefulWidget {
//   final String block,room;
//   Streambuilder({this.block,this.room});
//   @override
//   _StreambuilderState createState() => _StreambuilderState(block,room);
// }

// class _StreambuilderState extends State<Streambuilder> {
//   final String block,room;
//   _StreambuilderState(this.block,this.room);

//   Future<void> _tryagain() async
//   {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () async{
//         _tryagain();
//       },
//       // child:
//     );
//   }
// }

// import 'package:flutter/material.dart';

// import 'showStudent.dart';
// class ShowRooms extends StatefulWidget {
//   @override
//   _ShowRoomsState createState() => _ShowRoomsState();
// }

// class _ShowRoomsState extends State<ShowRooms> {
//   var _value='A';
//   var _roomNo;
//   var _enNo;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Show Rooms"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             DropdownButton(
//               value: _value,
//               items: [
//                 DropdownMenuItem(value: 'A',child: Text("A"),),
//                 DropdownMenuItem(value: 'B',child: Text("B"),),
//               ],
//               onChanged: (value)=>{
//                 setState(()=>{
//                   _value=value
//                 })
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(
//                 hintText: "Enter Room No.",
//                 prefixIcon: Icon(
//                   Icons.email,
//                   size: 30,
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//               onChanged: (value)=>{
//                 setState((){

//                 _roomNo=value;
//                 })
//               },
//             ),
//           TextFormField(
//               decoration: InputDecoration(
//                 hintText: "Enter Enrollment Number",
//                 prefixIcon: Icon(
//                   Icons.email,
//                   size: 30,
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//               onChanged: (value)=>{
//                 setState((){

//                 _enNo=value;
//                 })
//               },
//             ),
//             FlatButton(
//                     color: Colors.blue,
//                     splashColor: Colors.white,
//                     highlightColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.blue, width: 1),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     height:40.0,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Fetch Student",
//                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 10.0,),
//                         Icon(
//                           Icons.person_add_outlined,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                     onPressed: () {

//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
