import 'package:flutter/material.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  @override
  _KnowledgeBaseScreenState createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Knowledge Base",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15.0,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 2.0),
                  child: Theme(
                    data: ThemeData(hintColor: Colors.transparent),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabled: false,
                        contentPadding: EdgeInsets.only(bottom: 18),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF6991C7),
                          size: 24.0,
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "FAQ",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            onTap: null,
            contentPadding: EdgeInsets.only(left: 10),
            title: Text("Bagaimana cara mendapatkan koin Hasjrat?"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }
}
