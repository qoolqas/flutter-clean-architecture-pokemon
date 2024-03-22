import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';

import '../../../../core/resource/data_state.dart';

abstract class PokemonRepository{
  Future<DataState<List<PokemonEntity>>> getPokemon();
  Future<DataState<PokemonEntity>> getDetailPokemon(String name);

  Future<List<PokemonEntity>> getSavedPokemon();
  Future<void> savePokemon(PokemonEntity pokemonEntity);
  Future<void> removePokemon(PokemonEntity pokemonEntity);
}