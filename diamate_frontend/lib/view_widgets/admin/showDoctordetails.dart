import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';

class ShowDoctorDetails extends StatelessWidget {
  final String name;
  final String specialty;

  ShowDoctorDetails({required this.name, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text('Doctor Details'),
  ),
  backgroundColor: Color.fromARGB(255, 2, 12, 68),
  body: ListView(
    padding: EdgeInsets.all(0),
    children: [
      Icon(Icons.person, size: 200, color: Color.fromARGB(255, 255, 255, 255)),
      Arc(
        edge: Edge.TOP,
        arcType: ArcType.CONVEY,
        height: 30.0,
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 12, 68),
                  ),
                ),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 16,
                   // fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 2, 12, 68),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Experience:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 12, 68),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '9 years',
                      style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 2, 12, 68),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 12, 68),
                  ),
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                 
                  child: Text(
                    'description dftntrmetermbdfb sgrbntbdgbgfmrynbnbdfbegrgsvfdbgfb dbtnrnvm gewfwgfdbjfbnjnvfnvnergnrnengn enbf erbbnernbmnbebnejgnwlfnwelkvnb reerbmebnbnerjgnjer v regnrengjnbgbnjgnfmb gdbet ergnbmnfmb re bfd be',
                    style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 2, 12, 68),
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  

                ),
                SizedBox(height: 10),
                
                 
                    Text(
                      'BM&DC Registration Number:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 12, 68),
                      ),
                    ),
                    SizedBox(width: 5),
                    SingleChildScrollView(
                 
                  child: Text(
                    'description dftntrmetermbdfb sgrbntbdgbgfmrynbnbdfbegrgsvfdbgfb dbtnrnvm gewfwgfdbjfbnjnvfnvnergnrnengn enbf erbbnernbmnbebnejgnwlfnwelkvnb reerbmebnbnerjgnjer v regnrengjnbgbnjgnfmb gdbet ergnbmnfmb re bfd be',
                    style: TextStyle(
                      fontSize: 16,
                      //fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 2, 12, 68),
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  

                ),
                  ],
                ),
            
          ),
        ),
      ),
    ],
  ),
  bottomNavigationBar: buildBottomAppBar(),
);


  }
  BottomAppBar buildBottomAppBar() {
  return BottomAppBar(
    color: Color.fromARGB(255, 2, 12, 68),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle reject button press
            print("rejected");
          },
          child: Text(
            'Reject',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 2, 12, 68),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle verify button press
            print("verified");
          },
          child: Text(
            'Verify',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 2, 12, 68),
            ),
          ),
        ),
      ],
    ),
  );
}

}
