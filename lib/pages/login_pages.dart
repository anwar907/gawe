part of 'pages.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiServiceController user = Get.put(ApiServiceController());
  final Profile profile = Get.put(Profile());
  var usernameEmail = TextEditingController();
  var password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  Widget _usernameInput() {
    return TextFormField(
      controller: usernameEmail,
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF999999),
        ),
        fillColor: Colors.white,
      ),
      textInputAction: TextInputAction.next,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      controller: password,
      keyboardType: TextInputType.text,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF999999),
        ),
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      textInputAction: TextInputAction.done,
      validator: (password) {
        Pattern number = r'^(?=.*[0-9]+.*)';
        Pattern alphabet = r'(?=.*[a-zA-Z]+.*)';
        Pattern sixChar = r'[0-9a-zA-Z]{6,}$';

        RegExp regex = new RegExp(number);
        if (!regex.hasMatch(password)) {
          return 'Password must contain numbers';
        } else {
          regex = new RegExp(alphabet);
          if (!regex.hasMatch(password)) {
            return 'Password must contain alphabets';
          } else {
            regex = new RegExp(sixChar);
            if (!regex.hasMatch(password)) {
              return 'Password must contain at least 6 characters';
            }
            return null;
          }
        }
      },
    );
  }

  Widget _submitButton() {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: StadiumBorder(), primary: Color(0xFFF9663A)),
        onPressed: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog());

          var email = EmailValidator.validate(usernameEmail.text)
              ? usernameEmail.text
              : "";

          var result = await user.loginUser(email, password.text);
          // if (result == null) {
          //   await profile.userProfile();

          //   user.setEntry('Login');
          //   Navigator.pop(context, true);
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ProfilePages(),
          //     ),
          //   );
          // } else {
          //   Navigator.pop(context, true);
          //   toastMessage(result);
          // }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePages()));
        },
        child: Text(
          "Join Course",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Image(
      image: AssetImage(
        "assets/login.png",
      ),
      width: 178.0,
      height: 140.0,
      fit: BoxFit.fill,
    );
  }

  Widget _greet() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Welcome Back!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _usernameInput(),
            SizedBox(
              height: 10,
            ),
            _passwordInput(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      _logo(),
                      SizedBox(height: 3.0),
                      _greet(),
                      SizedBox(height: 3.0),
                      _emailPasswordWidget(),
                      SizedBox(height: 6.0),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
