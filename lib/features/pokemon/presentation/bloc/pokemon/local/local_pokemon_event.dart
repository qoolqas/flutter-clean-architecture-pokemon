
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:equatable/equatable.dart';

abstract class LocalPokemonEvent extends Equatable {
  final PokemonEntity ? pokemon;
  const LocalPokemonEvent({this.pokemon});

  @override
  List<Object> get props => [pokemon!];
}

class GetSavedPokemon extends LocalPokemonEvent {
  const GetSavedPokemon();
}

class RemovePokemon extends LocalPokemonEvent {
  const RemovePokemon(PokemonEntity pokemonEntity) : super(pokemon: pokemonEntity);
}

class SavePokemon extends LocalPokemonEvent {
  const SavePokemon(PokemonEntity pokemonEntity) : super(pokemon: pokemonEntity);
}