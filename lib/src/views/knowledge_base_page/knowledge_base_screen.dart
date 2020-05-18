import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_bloc.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_event.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_state.dart';
import 'package:salles_tools/src/services/knowledge_base_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/knowledge_base_page/ebook_screen.dart';

class KnowledgeBaseScreen extends StatefulWidget {
  @override
  _KnowledgeBaseScreenState createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  ScrollController _hideButtonController;
  var searchCtrl = new TextEditingController();

  var _isVisible;

  void searchQnA(String query) {
    // ignore: close_sinks
    final qnaBloc = BlocProvider.of<KnowledgeBaseBloc>(context);
    qnaBloc.add(SearchKnowledgeBase(query));
  }

  void _onSeeEbook() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => KnowledgeBaseBloc(KnowledgeBaseService()),
          child: EbookScreen(),
        ),
        transitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final qnaBloc = BlocProvider.of<KnowledgeBaseBloc>(context);
    qnaBloc.add(FetchKnowledgeBase());

    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener((){
      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse){
        if(_isVisible == true) {
          setState((){
            _isVisible = false;
          });
        }
      } else {
        if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
          if(_isVisible == false) {
            setState((){
              _isVisible = true;
            });
          }
        }
      }});
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
          "Informasi",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: searchContent(),
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
        child: SingleChildScrollView(
          controller: _hideButtonController,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 17, top: 20),
                child: Text(
                  "FAQ",
                  style: TextStyle(
                    letterSpacing: 0.8,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              BlocBuilder<KnowledgeBaseBloc, KnowledgeBaseState>(
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = searchCtrl == null
                            ? state.salesData.data.where((f) => f.publish == true && f.draft == false).toList()[index]
                            : state.salesData.data.where((f) => f.publish == true && f.draft == false && f.question.toLowerCase().contains(searchCtrl.text.toLowerCase())).toList()[index];

                        return ExpansionTile(
                          title: Text("${data.question}",
                            style: TextStyle(
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 17, bottom: 5, right: 17),
                                    child: Text("${data.answer}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      itemCount: searchCtrl == null
                          ? state.salesData.data.where((f) => f.publish == true && f.draft == false).toList().length
                          : state.salesData.data.where((f) => f.publish == true && f.draft == false && f.question.toLowerCase().contains(searchCtrl.text.toLowerCase())).toList().length,
                    );
                  }

                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 1000),
        child: FloatingActionButton.extended(
          onPressed: () {
            _onSeeEbook();
          },
          label: Text("Ebook"),
          icon: Icon(Icons.picture_as_pdf),
          backgroundColor: HexColor('#C61818'),
        ),
      ),
    );
  }

  Widget searchContent() {
    return Padding(
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
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Cari",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: searchCtrl,
                onEditingComplete: () {
                  searchQnA(searchCtrl.text);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
