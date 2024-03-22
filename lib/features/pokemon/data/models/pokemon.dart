import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:floor/floor.dart';
import '../../../../core/constants/constants.dart';

@Entity(tableName: 'pokemon',primaryKeys: ['url'])
class PokemonModel extends PokemonEntity {
  const PokemonModel({
    String ? name,
    String ? url
  }): super(
    name: name,
    url: url,
  );

  factory PokemonModel.fromJson(Map < String, dynamic > map) {
    return PokemonModel(
      name: map['name'] ?? "",
      url: map['url'] ?? ""
    );
  }

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    return PokemonModel(
        name: entity.name,
        url: entity.url
    );
  }
}