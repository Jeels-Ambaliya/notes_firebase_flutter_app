import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/firebase_auth_helper.dart';
import '../../helper/firestore_helper.dart';
import '../components/my_drawer.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final GlobalKey<FormState> insertFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  String? title;
  String? body;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      // backgroundColor: const Color(0xfff9eeff),

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfff9eeff),
        title: const Text(
          "HOME PAGE",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuthHelper.firebaseAuthHelper.logOut();

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login_page', (route) => false);
            },
            icon: const Icon(Icons.power_settings_new),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirestoreHelper.firestoreHelper.fetchRecords(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text("Error : ${snapShot.error}"),
            );
          } else if (snapShot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapShot.data;

            if (data == null) {
              return const Center(
                child: Text("No Any Data Available...."),
              );
            } else {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                  data.docs;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: allDocs.length,
                  itemBuilder: (context, i) {
                    return
                        //   Card(
                        //   child: ListTile(
                        //     isThreeLine: true,
                        //     leading: Text(
                        //       // allDocs[i].id,
                        //       "${i + 1}",
                        //       style: GoogleFonts.poppins(
                        //         textStyle: const TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ),
                        //     title: Text(
                        //       allDocs[i].data()['title'],
                        //       style: GoogleFonts.poppins(
                        //         textStyle: const TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ),
                        //     subtitle: Text(
                        //       "${allDocs[i].data()['body']}",
                        //       style: GoogleFonts.poppins(
                        //         textStyle: const TextStyle(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //     trailing: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         IconButton(
                        //           onPressed: () {
                        //             Map<String, dynamic> updateData = {
                        //               "title": allDocs[i].data()['title'],
                        //               "body": allDocs[i].data()['body'],
                        //             };
                        //             validateUpdate(
                        //                 id: allDocs[i].id, data: updateData);
                        //           },
                        //           icon: const Icon(
                        //             Icons.edit_outlined,
                        //             color: Colors.blue,
                        //           ),
                        //         ),
                        //         IconButton(
                        //           onPressed: () async {
                        //             await FirestoreHelper.firestoreHelper
                        //                 .deleteRecords(id: allDocs[i].id);
                        //
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               const SnackBar(
                        //                 content:
                        //                     Text("Record Deleted Successfully..."),
                        //                 backgroundColor: Colors.redAccent,
                        //                 behavior: SnackBarBehavior.floating,
                        //               ),
                        //             );
                        //           },
                        //           icon: const Icon(
                        //             Icons.delete_outline,
                        //             color: Colors.red,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                        Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> updateData = {
                            "title": allDocs[i].data()['title'],
                            "body": allDocs[i].data()['body'],
                          };
                          validateUpdate(id: allDocs[i].id, data: updateData);
                        },
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: Colors.deepPurple.shade300,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(3, 3),
                                color: Color(0xfff9eeff),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 15,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 20,
                                    right: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allDocs[i].data()['title'],
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${allDocs[i].data()['body']}",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Are you sure?'),
                                          content: const Text(
                                              'This action will permanently delete this data'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await FirestoreHelper
                                                    .firestoreHelper
                                                    .deleteRecords(
                                                        id: allDocs[i].id);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        "Record Deleted Successfully..."),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                  ),
                                                );

                                                Navigator.pop(context);
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: My_Drawer(user: data['user']),
      floatingActionButton: FloatingActionButton(
        onPressed: validateInsert,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  validateInsert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            "Add Records",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: Form(
          key: insertFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Title First.....";
                  }
                  return null;
                },
                onSaved: (val) {
                  title = val;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Enter Title here....",
                  labelText: "Title",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: Colors.deepPurple,
                    ),
                  ),
                  child: TextFormField(
                    controller: bodyController,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      setState(() {
                        body = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Body Here....";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      hintText: "Body",
                      hintStyle: TextStyle(),
                      fillColor: Color(0xfff9eeff),
                      filled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            child: const Text("Add"),
            onPressed: () async {
              if (insertFormKey.currentState!.validate()) {
                insertFormKey.currentState!.save();

                Map<String, dynamic> records = {
                  "title": title,
                  "body": body,
                };

                await FirestoreHelper.firestoreHelper
                    .insertRecords(data: records);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Record Inserted Successfully..."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                titleController.clear();
                bodyController.clear();

                setState(() {
                  title = null;
                  body = null;
                });

                Navigator.pop(context);
              }
            },
          ),
          OutlinedButton(
            child: const Text("Cancel"),
            onPressed: () async {
              titleController.clear();
              bodyController.clear();

              setState(() {
                title = null;
                body = null;
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  validateUpdate({required String id, required Map<String, dynamic> data}) {
    titleController.text = data['title'];
    bodyController.text = data['body'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            "Add Records",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: Form(
          key: updateFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Title First.....";
                  }
                  return null;
                },
                onSaved: (val) {
                  title = val;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Enter Title here....",
                  labelText: "Title",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: Colors.deepPurple,
                    ),
                  ),
                  child: TextFormField(
                    controller: bodyController,
                    textInputAction: TextInputAction.done,
                    onSaved: (val) {
                      setState(() {
                        body = val;
                      });
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Body Here....";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                          width: 2,
                        ),
                      ),
                      hintText: "Body",
                      hintStyle: TextStyle(),
                      fillColor: Color(0xfff9eeff),
                      filled: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            child: const Text("Update"),
            onPressed: () async {
              if (updateFormKey.currentState!.validate()) {
                updateFormKey.currentState!.save();

                Map<String, dynamic> records = {
                  "title": title,
                  "body": body,
                };

                await FirestoreHelper.firestoreHelper
                    .updateRecord(data: records, id: id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Record Updated Successfully..."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                titleController.clear();
                bodyController.clear();

                setState(() {
                  title = null;
                  body = null;
                });

                Navigator.pop(context);
              }
            },
          ),
          OutlinedButton(
            child: const Text("Cancel"),
            onPressed: () async {
              titleController.clear();
              bodyController.clear();

              setState(() {
                title = null;
                body = null;
              });

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
