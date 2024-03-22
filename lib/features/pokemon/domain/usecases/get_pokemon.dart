import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';

class GetPokemonUseCase implements UseCase<DataState<List<PokemonEntity>>,void>{
  final PokemonRepository _pokemonRepository;

  GetPokemonUseCase(this._pokemonRepository);
  @override
  Future<DataState<List<PokemonEntity>>> call({void params}) {
    return _pokemonRepository.getPokemon();
  }

}