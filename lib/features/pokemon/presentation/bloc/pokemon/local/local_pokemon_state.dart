
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../../../domain/entities/pokemon.dart';

abstract class LocalPokemonState extends Equatable {
  final List<PokemonEntity> ? pokemon;

  const LocalPokemonState({this.pokemon});

  @override
  List<Object> get props => [pokemon!];
}

class LocalPokemonLoading extends LocalPokemonState {
  const LocalPokemonLoading();
}

class LocalPokemonDone extends LocalPokemonState {
  const LocalPokemonDone(List<PokemonEntity> pokemon)
      : super(pokemon: pokemon);
}