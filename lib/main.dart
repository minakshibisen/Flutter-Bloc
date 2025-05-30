import 'package:bloc_flutter/bloc/attendance/attendance_bloc.dart';
import 'package:bloc_flutter/bloc/auth/auth_bloc.dart';
import 'package:bloc_flutter/bloc/favoritelist/favorite_list_bloc.dart';
import 'package:bloc_flutter/bloc/login/login_bloc.dart';
import 'package:bloc_flutter/bloc/post/post_bloc.dart';
import 'package:bloc_flutter/repository/auth_repository.dart';
import 'package:bloc_flutter/repository/favorite_repo.dart';
import 'package:bloc_flutter/repository/location_service_repo.dart';
import 'package:bloc_flutter/theme/theme.dart';
import 'package:bloc_flutter/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 👈 initialize Firebase here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

        providers: [
          BlocProvider(create: (_) => LoginBloc(locationService: LocationService())),
          BlocProvider(create: (_) => FavoriteListBloc(FavoriteRepository())),
          BlocProvider(create: (_) => PostBloc()),
          BlocProvider(create: (_) => AuthBloc(AuthRepository())),
          BlocProvider(create: (_) => AttendanceBloc(locationService: LocationService())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: SplashScreen(),
        ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
