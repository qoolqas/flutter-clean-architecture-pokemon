import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';

class RemovePokemonUseCase implements UseCase<void,PokemonEntity>{
  final PokemonRepository _pokemonRepository;

  RemovePokemonUseCase(this._pokemonRepository);
  
  @override
  Future<void> call({PokemonEntity ? params}) {
    return _pokemonRepository.removePokemon(params!);
  }

}