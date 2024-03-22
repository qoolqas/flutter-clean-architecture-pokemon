import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';

class SavePokemonUseCase implements UseCase<void,PokemonEntity>{
  final PokemonRepository _pokemonRepository;

  SavePokemonUseCase(this._pokemonRepository);

  @override
  Future<void> call({PokemonEntity ? params}) {
    return _pokemonRepository.savePokemon(params!);
  }

}