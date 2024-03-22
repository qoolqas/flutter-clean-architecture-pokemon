import 'dart:math';

import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../injection_container.dart';
import '../../bloc/pokemon/local/local_pokemon_bloc.dart';

class PokemonDetailView extends HookWidget {
  final PokemonEntity? pokemon;

  const PokemonDetailView({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalPokemonBloc>(),
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
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPokemonTitle(),
          _buildPokemonImage(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: _buildFloatingActionButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPokemonTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            pokemon!.name!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
          'https://static.wikia.nocookie.net/vsbattles/images/0/04/025Pikachu_XY_anime_4.png/revision/latest?cb=20180310153929',
          fit: BoxFit.cover),
    );
  }
  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _onSaveButtonPressed(context),
        child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.red,
            ),
            width: 50,
            height: 50,

            child: const Icon(Icons.bookmark,color: Colors.white),),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onSaveButtonPressed(BuildContext context) {
    final random = Random();
    final bool isYes = random.nextBool();
    if (isYes) {
      BlocProvider.of<LocalPokemonBloc>(context).add(SavePokemon(pokemon!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text('Pokemon saved successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text('Pokemon not saved.'),
        ),
      );
    }
  }
}
