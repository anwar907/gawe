part of 'pages.dart';

class ProfilePages extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  final Profile profile = Get.put(Profile());
  @override
  void initState() {
    super.initState();
  }

  Widget titleSetting(String text) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget userImage() {
    return Container(
      alignment: Alignment.topCenter,
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.lightBlue),
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/login.png")),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.redAccent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Text(
              "ID CARD",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              )
            ],
          ),
          body: Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      padding: EdgeInsets.only(top: 60),
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Card(
                        color: Color(0xFF3C9D9B),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Column(
                          children: [
                            Center(
                                child: Obx(() => profile.fullName.value == ""
                                    ? Text(
                                        "failed load FullName",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        profile.fullName.value,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ))),
                            Container(
                              height: 170,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  shape: BoxShape.rectangle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 2.0, //extend the shadow
                                        offset: Offset(
                                          0.0, // Move to right 10  horizontally
                                          13.0, // Move to bottom 10 Vertically
                                        ))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('Email'),
                                      ),
                                      Text(' : '),
                                      Expanded(child: Text("testing@mogawe.id"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Text('Education')),
                                      Text(' : '),
                                      Expanded(child: Text("SMA/sederajat"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Text('Level')),
                                      Text(' : '),
                                      Expanded(child: Text("1"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(child: Text('Gender  ')),
                                      Text(' : '),
                                      Expanded(child: Text("M"))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                'MO-FG7WXX',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: userImage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
