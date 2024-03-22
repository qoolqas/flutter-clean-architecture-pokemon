import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/pages/home/list_screen.dart';
import 'package:clean_architecture/features/pokemon/presentation/pages/saved_pokemon/saved_pokemon.dart';
import 'package:flutter/material.dart';

import '../../features/pokemon/presentation/pages/detail/detail_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const ListPokemon());

      case '/PokemonDetail':
        return _materialRoute(PokemonDetailView(pokemon: settings.arguments as PokemonEntity));

      case '/SavedPokemon':
        return _materialRoute(const SavedPokemon());

      default:
        return _materialRoute(const ListPokemon());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}