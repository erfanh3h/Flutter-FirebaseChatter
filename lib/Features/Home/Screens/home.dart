import 'package:flutter/material.dart';
import 'package:flutterchat/Core/Widgets/loading-widget.dart';
import 'package:flutterchat/Features/Home/Providers/home.dart';
import 'package:provider/provider.dart';

import '../../../Core/Configs/routes.dart';
import '../../../Core/Widgets/simple-header.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
      child: HomeTile(),
    );
  }
}

class HomeTile extends StatefulWidget {
  @override
  _HomeTileState createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  @override
  void initState() {
    Future.microtask(
        () => Provider.of<HomeProvider>(context,listen: false).autoLogin(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeProvider>(
        builder: (ctx, provider, _) => LayoutBuilder(
          builder: (ctx, cons) => provider.isLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SimpleHeader(
                      title: 'خوش آمدید',
                    ),
                    SizedBox(height: 50.0),
                    Material(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 5,
                      child: MaterialButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.signIn),
                        minWidth: 200.0,
                        // height: 42.0,
                        child: Text(
                          'ورود',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Material(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 5,
                      child: MaterialButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.signUp),
                        minWidth: 200.0,
                        // height: 42.0,
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
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
