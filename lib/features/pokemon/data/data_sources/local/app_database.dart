import 'package:clean_architecture/features/pokemon/data/data_sources/local/dao/pokemon_dao.dart';
import 'package:clean_architecture/features/pokemon/data/models/pokemon.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [PokemonModel])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}