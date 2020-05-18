import 'package:flutter/material.dart';

class PrivacyPoliceView extends StatefulWidget {
  @override
  _PrivacyPoliceViewState createState() => _PrivacyPoliceViewState();
}

class _PrivacyPoliceViewState extends State<PrivacyPoliceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Kebijakan Privasi",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Center(
                child: MergeSemantics(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(20, 10.0, 20.0, 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      // Title
                                      titleText(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // First Paragraph
                                      fifthParagraph(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Second Paragraph
                                      secondParagraph(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Third Paragraph
                                      thirdParagraph(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      fourthParagraph(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      fifthParagraph(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      sixthParagraph()
                                    ],
                                  )),
                            ],
                          ),
                          elevation: 15.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleText() {
    return Text(
      "Privacy Policy",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget firstParagraph() {
    return Text(
      "PT Hasjrat Abadi is committed to respecting and protecting to the best of its ability, any personal information received from users of the application. PT Hasjrat Abadi continually seeks to improve the security standards of its application. However, please note that PT Hasjrat Abadi will not be responsible for any losses. PT Hasjrat Abadi stores personal data of the users of the application on a server located in a data center designated by PT Hasjrat Abadi. Such data centers may be located overseas.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }

  Widget secondParagraph() {
    return Text(
      "When you download or use the application, PT Hasjrat Abadi may also collect information about you and your mobile device for the purposes of system administration. This may include location information as authorized by you and your device. We may use this information to provide you with location based services, such as advertising, search results, and other personalized content. Most mobile devices allow you to control or disable location services in the device's setting's menu. If you have questions about how to disable your device's location services, we recommend you contact your mobile service carrier or the manufacturer of your particular device.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }

  Widget thirdParagraph() {
    return Text(
      "PT Hasjrat Abadi will only use personal information received from users of the application in accordance with purposes in which the personal information was provided to PT Hasjrat Abadi, which includes but is not limited to communicating and providing more detailed information to the users of the application. Any use of personal information will be in accordance with the consents given by the individual owner of the personal information, and such consent may be withdrawn at any time. Personal information will not be disclosed to third parties unless consent is given by the user. However, PT Hasjrat Abadi reserves the right to use or disclose personal information in relation to any legal proceedings, including but not limited to law enforcement orders, subpoenas and court orders, in connection with the protection of the legal rights of PT Hasjrat Abadi and/or the legal rights of the users of the application, where aplicable. The application will, from time to time, contain links to third party URLs or applications. Except as otherwise expressly included in this Privacy Policy, this document addresses only the use, disclosure and transfer of information PT Hasjrat Abadi collects from its users.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }

  Widget fourthParagraph() {
    return Text(
      "You can edit the personal information you provide to PT Hasjrat Abadi at any time, including opting out of receiving communications from us of withdrawing your consent to usage of your personal information.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }

  Widget fifthParagraph() {
    return Text(
      "However, PT Hasjrat Abadi reserves the right to send users of the application certain communications relating to the application service, such as service announcements and administrative messages, without offering the user the opportunity to opt out of receiving them.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }

  Widget sixthParagraph() {
    return Text(
      "By accessing and using the application is deemed to have read, understood and given consent for the collection, use, disclosure and retention of his/her personal information as described in the above application. PT Hasjrat Abadi may amend this Privacy Policy at any time by posting the amended terms on this site. PT Hasjrat Abadi will notify you via email or other means of communication in the event of any material changes to this Privacy Policy.",
      style: TextStyle(fontSize: 15),
      textAlign: TextAlign.justify,
    );
  }
}
