import 'package:clean_architecture/features/pokemon/data/models/pokemon.dart';
import 'package:floor/floor.dart';

@dao
abstract class PokemonDao{
  @Insert()
  Future<void> insertPokemon(PokemonModel pokemonModel);

  @delete
  Future<void> deletePokemon(PokemonModel pokemonModel);

  @Query('SELECT * FROM pokemon')
  Future<List<PokemonModel>> getPokemon();
}