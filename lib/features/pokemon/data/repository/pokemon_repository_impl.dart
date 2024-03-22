import 'dart:io';

import 'package:clean_architecture/features/pokemon/data/data_sources/local/app_database.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/core/resource/data_state.dart';
import 'package:clean_architecture/features/pokemon/data/data_sources/remote/pokemon_api_service.dart';
import 'package:clean_architecture/features/pokemon/data/models/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository{
  final PokemonApiService _pokemonApiService;
  final AppDatabase _appDatabase;
  PokemonRepositoryImpl(this._pokemonApiService, this._appDatabase);

  @override
  Future<DataState<List<PokemonModel>>> getPokemon() async {
    try{
      final httpResponse = await _pokemonApiService.getPokemon(
      );

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      }else{
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PokemonModel>> getDetailPokemon(String name) async {
    try{
      final httpResponse = await _pokemonApiService.getDetailPokemon(
        name: name
      );

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      }else{
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<List<PokemonModel>> getSavedPokemon() {
    return _appDatabase.pokemonDao.getPokemon();
  }

  @override
  Future<void> removePokemon(PokemonEntity pokemonEntity) {
    return _appDatabase.pokemonDao.deletePokemon(PokemonModel.fromEntity(pokemonEntity));
  }

  @override
  Future<void> savePokemon(PokemonEntity pokemonEntity) {
    return _appDatabase.pokemonDao.insertPokemon(PokemonModel.fromEntity(pokemonEntity));
  }

}