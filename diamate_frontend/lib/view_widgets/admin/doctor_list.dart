import 'package:flutter/material.dart';
import 'OnePost.dart';
import 'showDoctordetails.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Doctor List';
  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 8, 22, 106),
            actionsIconTheme: IconThemeData(color: Colors.white),
            title: Text(widget.title,
                selectionColor: Colors.white,
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                color: Colors.white,
                onPressed: () {
                  // Action for the first button
                  print('First button pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                onPressed: () {
                  // Action for the second button
                  print('Second button pressed');
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  // Search box with shadow
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        fillColor:
                            Colors.white, // You can change the fill color
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Add action for the search icon button (e.g., initiate search)
                          },
                          icon: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25), // Spacing after search box
                  _buildDoctorlist(context),
                ],
              ),
            ),
          )),
    );
  }

  Future<List<Map<String, dynamic>>> fetchDoctors() async {
    // try {
    //   final response = await Requests.get(forum, timeoutSeconds: 120);

    //   if (response.statusCode == 200) {
    final List<dynamic> data;
    // data = json.decode(response.content());
    return [];
    //return data.cast<Map<String, dynamic>>();
    //   } else {
    //     throw Exception('Failed to load posts: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print('Error fetching posts: $e');
    //   throw Exception('Failed to load posts: $e');
    // }
  }

  /// Section Widget
  Widget _buildDoctorlist(BuildContext context) {
    // return FutureBuilder<List<Map<String, dynamic>>>(
    //   future: fetchDoctors(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return CircularProgressIndicator(); // Display a loading indicator
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return Text('No posts available');
    //     } else {
    //       // Display the posts using ListView.builder
    //       return ListView.builder(
    //         physics: NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         //itemCount: snapshot.data!.length,
    //         itemCount: 10,
    //         itemBuilder: (context, index) {
    //           return Padding(
    //             padding: EdgeInsets.symmetric(
    //                 vertical: 8.0), // Adjust the vertical spacing as needed
    //             child: OnePost(post: snapshot.data![index]),
    //           );
    //         },
    //       );
    //     }
    //   },
    // );

    return SingleChildScrollView(
  child: Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemCount: 15,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to another page and pass doctor's name and specialty
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowDoctorDetails(
                      name: 'Dr. Faria Afsana',
                      specialty: "Diabetics & Thyroid Specialist",
                    ),
                  ),
                );
              },
              child: _buildDoctorItem(
                'Dr. Faria Afsana',
                "Diabetics & Thyroid Specialist",
              ),
            );
          },
        ),
      ],
    ),
  ),
);

  }

  Widget _buildDoctorItem(String name, String specialty) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 211, 213, 224).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.person,
              size: 80, color: Color.fromARGB(255, 154, 163, 214)),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: const Color.fromARGB(255, 8, 22, 106),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            specialty,
            textAlign: TextAlign.center,
            selectionColor: Colors.white,
          )
        ],
      ),
    );
  }
}
