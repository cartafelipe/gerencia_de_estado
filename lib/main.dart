import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gerencia_de_estado/infra/bindings/my_bindings.dart';
import 'package:gerencia_de_estado/pages/login_page.dart';
import 'package:get/get.dart';

import 'package:gerencia_de_estado/page1.dart';
import 'package:gerencia_de_estado/src/controller.dart';
import 'package:gerencia_de_estado/src/names_search.dart';

import 'infra/navigation/navigation.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Routes.initialRoute,
      builder: (_, snapshot) => GetMaterialApp(
        title: 'GetDemo',
        initialRoute: snapshot.data ?? Routes.LOGIN,
        namedRoutes: Nav.routes,
        supportedLocales: [
          const Locale('pt', ''),
        ],
        localizationsDelegates: [
          const DemoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //without this line cutButtonLabel was called on null: NoSuchMethodError
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // smartManagement: SmartManagement.keepFactory,
      initialBinding: LoginBindings(),
      onGenerateTitle: (context) => DemoLocalizations.of(context).title,
      localizationsDelegates: [
        const DemoLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations
            .delegate, //without this line cutButtonLabel was called on null: NoSuchMethodError
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        // const Locale('es', ''),
        const Locale('pt', ''),
        // const Locale('en', ''),
      ],
      title: '',

      namedRoutes: {
        '/': GetRoute(page: LoginPage(), binding: LoginBindings()),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //  home: MyHomePage('Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NameSearch(),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.pop(context);
                Navigator.pop(context);
                Get.to(Page1(), transition: Transition.cupertino);
              },
            ),
            GetX<LoginController>(
              builder: (c) => ListTile(
                title: Text('Sair'),
                onTap: () {
                  c.logOut();
                },
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetX<LoginController>(
              builder: (_) => Text(_.loginx.login.value),
            ),
            Text(
              DemoLocalizations.of(context).body,
            ),
            GetX<HomeController>(
              builder: (c) => Text(c.count.string),
            ),
            GetX<LoginController>(
              builder: (c) => RaisedButton(
                child: Text('LogOut'),
                onPressed: () {
                  c.logOut();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeController.to.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Scaffold(
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: TextField(
//                 decoration: InputDecoration(labelText: 'Login'),
//               ),
//             ),
//             Container(
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Senha',
//                 ),
//               ),
//             ),
//             GetX<LoginController>(
//               init: LoginController(),
//               //  autoRemove: false,
//               builder: (_) => IconButton(
//                   icon: Icon(Icons.account_box),
//                   onPressed: () {
//                     _.logIn('senha', 'Felipe');
//                   }),
//             ),
//             GetX<LoginController>(
//               builder: (_) => Text(_.loginx.login.string),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
      'body': 'You have pushed the button this many times:',
    },
    'es': {
      'title': 'Hola Mundo',
      'body': 'You have pushed the button this many times:',
    },
    'pt': {
      'title': 'Olá Mundo',
      'body': 'Quantidade de vezes que pressionou o botão:',
    }
  };
  String get body {
    return _localizedValues[locale.languageCode]['body'];
  }

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
