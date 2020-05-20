import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_bloc.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_event.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_state.dart';
import 'package:salles_tools/src/models/knowledge_base_model.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:url_launcher/url_launcher.dart';

class EbookScreen extends StatefulWidget {
  @override
  _EbookScreenState createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final qnaBloc = BlocProvider.of<KnowledgeBaseBloc>(context);
    qnaBloc.add(FetchKnowledgeBase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Ebook",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<KnowledgeBaseBloc, KnowledgeBaseState>(
        listener: (context, state) {
          if (state is KnowledgeBaseLoading) {
            onLoading(context);
          }

          if (state is KnowledgeBaseDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: BlocBuilder<KnowledgeBaseBloc, KnowledgeBaseState>(
          builder: (context, state) {
            if (state is KnowledgeBaseError) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/error_banner.jpg", height: 200),
                      Text("502 Error Bad Gateway"),
                    ],
                  ),
                ),
              );
            }

            if (state is KnowledgeBaseFailed) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/no_data.png", height: 200),
                    ],
                  ),
                ),
              );
            }

            if (state is KnowledgeBaseSuccess) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.salesData.data.where((f) => f.urlFile != null && f.publish == true && f.draft != true).toList().length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 17,
                        mainAxisSpacing: 17,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemBuilder: (context, i) {
                        var data = state.salesData.data.where((f) => f.urlFile != null && f.publish == true && f.draft != true).toList()[i];
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${data.question}",
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      log.info(data.urlFile);
                                      launch("${data.urlFile}");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(9.0),
                                          topRight: Radius.circular(9.0),
                                        ),
                                        color: Color(0xfff4f4f4),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.download,
                                          size: 50,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}