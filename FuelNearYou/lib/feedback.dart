//ignore_members_deprecated

// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot, FirebaseFirestore, QuerySnapshot;
import 'navigation/navigation_bloc.dart';

class FeedbackPage extends StatelessWidget with NavigationStates {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Feedback(),
    );
  }
}

class Feedback extends StatefulWidget {
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final TextEditingController _addFeedBackContrl = new TextEditingController();
  final firestore =FirebaseFirestore.instance;

  String _uid = "";
  String _email = "";
  String _message = "";
  String count = "0";
  String feedback = "";

// 1st get the logged user id
  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    //current user
    User currentUser = await FirebaseAuth.instance.currentUser!;
    _uid = currentUser.uid;
    _email = currentUser.email!;
  }

//submit newly added feedback
  void _submitFeedback() async {
    feedback = _addFeedBackContrl.text;

// check the input is empty or null
    if (feedback == "") {
      _message = "Please fill and submit";
      showAlertDialog();
    } else {
      try {
        // send json data to firestore
        FirebaseFirestore.instance
            .collection('feedbacks')
            .doc()
            .set({'uid': _uid, 'feedback': feedback}).then((onValue) {
          _addFeedBackContrl.text = "";
          _message = "Successfully Added";

          showAlertDialog();
        });
      } catch (e) {
        _message = e.toString();
        showAlertDialog();
      }
    }
  }

// feedback update function
  void _updateFeedback(DocumentSnapshot doc) async {
    feedback = _addFeedBackContrl.text;
    //check feedback
    if (feedback == "") {
      _message = "Please add the updated feedback";
      showAlertDialog();
    } else {
      try {
        //update the document feedback field
        await firestore
            .collection('feedbacks')
            .doc(doc.id)
            .update({'feedback': feedback});
        _addFeedBackContrl.text = "";
        _message = "Updated successfully";
        showAlertDialog();
      } catch (e) {
        _message = e.toString();
        showAlertDialog();
      }
    }
  }

  /// ****update data dialog box input *******/
  ///
// use the DocumentSnapshot and get the selected document field data
// display the entered feedback hint text
// editing controller use the update the view field & get the data into database
  void updateData(DocumentSnapshot doc) async {
    await showDialog<String>(
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _addFeedBackContrl,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: feedback,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            // dialog box has two buttons
            actions: <Widget>[
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }),
              // after press save botton pass the document instance id and firestore field update
              TextButton(
                child: Text("Save"),
                onPressed: () {
                  _updateFeedback(doc);
                },
              ),
            ],
          );
        },
        context: context);
  }

  /// *************** document delete function ************************
  ///
  void deleteData(DocumentSnapshot doc) async {
    try {
      await firestore.collection('feedbacks').doc(doc.id).delete();
      _addFeedBackContrl.text = "";
      _message = "Feedback Delete Successfully";
      showAlertDialog();
    } catch (e) {
      _message = e.toString();
      showAlertDialog();
    }
  }

  ///************* using cards display inserted feedback ***********/
  Card buildFeedback(DocumentSnapshot doc) {
    // assiging the selected document feedback field data
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //display feedback
            Text(
              '${doc.data()}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // update button
                Container(
                  height: 45,
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 45),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Color.fromRGBO(255, 204, 0, 1)),
                  child: TextButton(
                      child:
                          Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        updateData(doc);
                      }),
                ),
                //delete button
                Padding(
                  padding: const EdgeInsets.only(
                      // left: 10,
                      //right: 60,
                      //bottom: 10,
                      ),
                  child: Container(
                    height: 45,
                    width: 100,
                    // margin: EdgeInsets.symmetric(horizontal: 45),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Colors.red),
                    child: TextButton(
                      onPressed: () => deleteData(doc),
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 45),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Color.fromRGBO(0, 214, 227, 1)),
      child: TextButton(
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _submitFeedback,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback"),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 214, 227, 1),
        ),
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Add Feedback...",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      style: TextStyle(fontSize: 15, color: Colors.black),
                      cursorColor: Colors.black,
                      controller: _addFeedBackContrl,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _submitButton(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),

                    //get the logged user entered feedback
                    StreamBuilder<QuerySnapshot>(
                        stream: firestore
                            .collection('feedbacks')
                            .where('uid', isEqualTo: _uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                children: snapshot.data!.docs
                                    .map((doc) => buildFeedback(doc))
                                    .toList());
                          } else {
                            return SizedBox();
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  ///***** Message display dialog box */
  showAlertDialog() {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Message'),
      content: Text(_message),
      actions: <Widget>[
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
