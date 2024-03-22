
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../../../domain/entities/pokemon.dart';

abstract class RemotePokemonState extends Equatable {
  final List<PokemonEntity> ? pokemon;
  final DioException ? exception;

  const RemotePokemonState({this.pokemon, this.exception});

  @override
  List<Object> get props => [pokemon!, exception!];
}

class RemotePokemonLoading extends RemotePokemonState {
  const RemotePokemonLoading();
}

class RemotePokemonDone extends RemotePokemonState {
  const RemotePokemonDone(List<PokemonEntity> pokemon)
      : super(pokemon: pokemon);
}

class RemotePokemonError extends RemotePokemonState {
  const RemotePokemonError(DioException error) : super(exception: error);
}