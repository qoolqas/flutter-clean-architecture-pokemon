import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/get_saved_pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/remove_pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/usecases/save_pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_event.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_event.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_pokemon.dart';
import 'local_pokemon_state.dart';

class LocalPokemonBloc extends Bloc<LocalPokemonEvent, LocalPokemonState> {

  final GetSavedPokemonUseCase _getSavedPokemonUseCase;
  final SavePokemonUseCase _savePokemonUseCase;
  final RemovePokemonUseCase _removePokemonUseCase;

  LocalPokemonBloc(
      this._getSavedPokemonUseCase,
      this._savePokemonUseCase,
      this._removePokemonUseCase,
      ) : super(const LocalPokemonLoading()){
    on <GetSavedPokemon> (onGetSavedPokemon);
    on <RemovePokemon> (onRemovePokemon);
    on <SavePokemon> (onSavePokemon);
  }

  Future<void> onGetSavedPokemon(GetSavedPokemon getSavedPokemon,Emitter<LocalPokemonState> emit) async {
    final dataState = await _getSavedPokemonUseCase();
    emit(LocalPokemonDone(dataState));
  }

  Future<void> onRemovePokemon(RemovePokemon removePokemon, Emitter<LocalPokemonState> emit) async {
    await _removePokemonUseCase(params: removePokemon.pokemon);
    final dataState = await _getSavedPokemonUseCase();
    emit(LocalPokemonDone(dataState));
  }

  Future<void> onSavePokemon(SavePokemon savePokemon, Emitter<LocalPokemonState> emit) async {
    await _savePokemonUseCase(params: savePokemon.pokemon);
    final dataState = await _getSavedPokemonUseCase();
    emit(LocalPokemonDone(dataState));
  }

}