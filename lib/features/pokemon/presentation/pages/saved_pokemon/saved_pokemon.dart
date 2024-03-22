

import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_bloc.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_event.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_state.dart';
import 'package:clean_architecture/features/pokemon/presentation/widgets/pokemon_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../injection_container.dart';

class SavedPokemon extends HookWidget {
  const SavedPokemon({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalPokemonBloc>()..add(const GetSavedPokemon()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title: const Text('Saved Pokemon', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalPokemonBloc, LocalPokemonState>(
      builder: (context, state) {
        if (state is LocalPokemonLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalPokemonDone) {
          return _buildPokemonsList(state.pokemon!);
        }
        return Container();
      },
    );
  }

  Widget _buildPokemonsList(List<PokemonEntity> pokemons) {
    if (pokemons.isEmpty) {
      return const Center(
          child: Text(
            'NO SAVED POKEMON',
            style: TextStyle(color: Colors.black),
          ));
    }

    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return PokemonWidget(
          pokemon: pokemons[index],
          isRemovable: true,
          onRemove: (pokemon) => _onRemovePokemon(context, pokemon),
          onPokemonPressed: (pokemon) => _onPokemonPressed(context, pokemon),
        );
      },
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onRemovePokemon(BuildContext context, PokemonEntity pokemon) {
    BlocProvider.of<LocalPokemonBloc>(context).add(RemovePokemon(pokemon));
  }

  void _onPokemonPressed(BuildContext context, PokemonEntity pokemon) {
    Navigator.pushNamed(context, '/PokemonDetails', arguments: pokemon);
  }
}