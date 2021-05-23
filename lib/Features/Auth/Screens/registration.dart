import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Core/Widgets/input-box.dart';
import '../../../Core/Widgets/loading-widget.dart';
import '../../../Core/Widgets/simple-header.dart';
import '../../../Core/Widgets/submit-button.dart';
import '../Providers/registration.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegistrationProvider>(
      create: (_) => RegistrationProvider(),
      child: RegistrationTile(),
    );
  }
}

class RegistrationTile extends StatelessWidget {
  const RegistrationTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
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
                      title: 'ثبت نام',
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
                      title: 'ثبت نام',
                      icon: Icons.add,
                      function:()=> provider.register(context),
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
