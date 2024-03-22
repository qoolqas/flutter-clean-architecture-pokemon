import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';

class GetSavedPokemonUseCase implements UseCase<List<PokemonEntity>,void>{
  final PokemonRepository _pokemonRepository;

  GetSavedPokemonUseCase(this._pokemonRepository);
  @override
  Future<List<PokemonEntity>> call({void params}) {
    return _pokemonRepository.getSavedPokemon();
  }

}