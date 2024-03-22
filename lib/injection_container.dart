import 'package:clean_architecture/features/pokemon/data/data_sources/local/app_database.dart';
import 'package:clean_architecture/features/pokemon/data/data_sources/remote/pokemon_api_service.dart';
import 'package:clean_architecture/features/pokemon/data/repository/pokemon_repository_impl.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/get_pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/get_saved_pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/remove_pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/save_pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_bloc.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database').build();
  sl.registerSingleton<AppDatabase>(database);

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<PokemonApiService>(PokemonApiService(sl()));

  sl.registerSingleton<PokemonRepository>(PokemonRepositoryImpl(sl(), sl()));

  sl.registerSingleton<GetPokemonUseCase>(GetPokemonUseCase(sl()));

  sl.registerSingleton<GetSavedPokemonUseCase>(GetSavedPokemonUseCase(sl()));
  sl.registerSingleton<SavePokemonUseCase>(SavePokemonUseCase(sl()));
  sl.registerSingleton<RemovePokemonUseCase>(RemovePokemonUseCase(sl()));

  sl.registerFactory<RemotePokemonBloc>(() => RemotePokemonBloc(sl()));
  sl.registerFactory<LocalPokemonBloc>(() => LocalPokemonBloc(sl(),sl(),sl()));
}
