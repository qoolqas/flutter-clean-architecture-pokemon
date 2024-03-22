import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_event.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_pokemon.dart';

class RemotePokemonBloc extends Bloc<RemotePokemonEvent, RemotePokemonState> {

  final GetPokemonUseCase _getPokemonUseCase;

  RemotePokemonBloc(this._getPokemonUseCase) : super(const RemotePokemonLoading()){
    on <GetPokemon>(onGetPokemon);
  }

  Future<void> onGetPokemon(GetPokemon event, Emitter<RemotePokemonState> emit) async {
    final dataState = await _getPokemonUseCase();
    if(dataState is DataSuccess && dataState.data!.isNotEmpty){
      emit(
        RemotePokemonDone(dataState.data!)
      );
    }
    if(dataState is DataFailed){
      emit(
        RemotePokemonError(dataState.error!)
      );
    }
  }

}