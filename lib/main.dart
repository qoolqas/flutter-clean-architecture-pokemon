import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_bloc.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_event.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/AppRoutes.dart';
import 'features/pokemon/presentation/pages/home/list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemotePokemonBloc>(
      create: (context) => sl()..add(const GetPokemon()),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: ListPokemon()
      ),
    );
  }
}