import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_state.dart';
import 'package:gen_ai_frontend/repositories/api_repository.dart';
import 'package:gen_ai_frontend/screens/dashboard.dart';
import 'package:gen_ai_frontend/screens/login_screen.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: ((context) => ApiRepository()))],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) =>
                  ApiBloc(apiRepository: context.read<ApiRepository>())))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<ApiBloc, ApiState>(
            builder: (apiContext, apiState) {
              return apiState.user.userId == null
                  ? const LoginScreen()
                  : const Dashboard();
            },
          ),
        ),
      ),
    );
  }
}
