import 'package:flutter/material.dart';

import 'OnePost.dart';
class AdminForumPage extends StatefulWidget {
  const AdminForumPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'Forum';
  @override
  State<AdminForumPage> createState() => _AdminForumPageState();
}

class _AdminForumPageState extends State<AdminForumPage> {
  

  void _incrementCounter() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    
     return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        
        backgroundColor: const Color.fromARGB(255, 8, 22, 106),
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.title,selectionColor: Colors.white,style: TextStyle(color: Colors.white)),

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
              _buildPostListComponent(context),
            ],
          ),
        )),
       
      ),
    );
    
  }


  Future<List<Map<String, dynamic>>> fetchPosts() async {
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
  Widget _buildPostListComponent(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No posts available');
        } else {
          // Display the posts using ListView.builder
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            //itemCount: snapshot.data!.length,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0), // Adjust the vertical spacing as needed
                child: OnePost(post: snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }
}
