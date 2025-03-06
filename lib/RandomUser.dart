import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final int age;
  final String email;
  final String country;
  final String path;
  final String state;
  final String phone;

  const User(
      {required this.name,
      required this.age,
      required this.email,
      required this.country,
      required this.path,
      required this.state,
      required this.phone});
  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['results'][0]; // Extract first user from results array
    return User(
        name: "${user['name']['first']} ${user['name']['last']}",
        age: user['dob']['age'],
        email: user['email'],
        country: user['location']['country'],
        path: user['picture']["medium"],
        state: user['location']["state"],
        phone: user['phone']);
  }
}

Future<User> fetchUser() async {
  final response = await http.get(Uri.parse("https://randomuser.me/api/"));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load User');
  }
}

class RandomUser extends StatefulWidget {
  const RandomUser({super.key});

  @override
  State<RandomUser> createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {
  late Future<User> futureUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUser = fetchUser();
  }

  void refresh() {
    setState(() {
      futureUser = fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Center(
        child: FutureBuilder(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(
                  color: Colors.deepPurple,

                  elevation: 30,
                  shadowColor: Colors.deepPurpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 3,
                      children: [
                        // Image.network(snapshot.data!.path),
                        // SizedBox(height: 20,),
                        Text(snapshot.data!.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 40,color: Colors.white)),
                        Text("Age: " + snapshot.data!.age.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 30,color: Colors.white)),
                        Text(snapshot.data!.country,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30,color: Colors.white)),
                        Text(snapshot.data!.email,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30,color: Colors.white)),
                        Text(snapshot.data!.state,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30,color: Colors.white)),
                        Text(snapshot.data!.phone,
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30,color: Colors.white)),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              refresh();
                            },
                            child: Text(
                              "Refresh",
                              style: TextStyle(fontSize: 23),
                            ))
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
