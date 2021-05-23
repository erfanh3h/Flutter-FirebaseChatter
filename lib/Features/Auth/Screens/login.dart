import 'package:flutter/material.dart';
import '../../../Core/Widgets/loading-widget.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/input-box.dart';
import '../../../Core/Widgets/simple-header.dart';
import '../../../Core/Widgets/submit-button.dart';
import '../Providers/login.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: LoginTile(),
    );
  }
}

class LoginTile extends StatelessWidget {
  const LoginTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (ctx, provider, _) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SimpleHeader(
                      title: 'ورود',
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    GlobalInputBox(
                      ctrl: provider.emailCtrl,
                      icon: Icons.email,
                      label: 'ایمیل',
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    GlobalInputBox(
                      ctrl: provider.passCtrl,
                      icon: Icons.lock,
                      label: 'رمز',
                      isSecure: true,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    SubmitButton(
                      title: 'ورود',
                      icon: Icons.login,
                      function: () => provider.login(context),
                      color: Theme.of(context).primaryColor,
                      fontColor: Colors.white70,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
