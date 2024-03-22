import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/features/pokemon/data/models/pokemon.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'pokemon_api_service.g.dart';

@RestApi(baseUrl: pokemonAPIBaseURL)
abstract class PokemonApiService {
  factory PokemonApiService(Dio dio) = _PokemonApiService;

  @GET('pokemon?limit=10&offset=0')
  Future<HttpResponse<List<PokemonModel>>> getPokemon();

  @GET('pokemon/{name}')
  Future<HttpResponse<PokemonModel>> getDetailPokemon(
      {@Path("name") name});
}
