

import 'package:clean_architecture/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_bloc.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/local/local_pokemon_event.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_bloc.dart';
import 'package:clean_architecture/features/pokemon/presentation/bloc/pokemon/remote/remote_pokemon_state.dart';
import 'package:clean_architecture/features/pokemon/presentation/widgets/pokemon_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPokemon extends StatelessWidget {
  const ListPokemon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody() ,
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pokemon',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedPokemonsViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemotePokemonBloc,RemotePokemonState> (
      builder: (_,state) {
        if (state is RemotePokemonLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemotePokemonError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemotePokemonDone) {
          return ListView.builder(
            itemBuilder: (context,index){
              return PokemonWidget(
                pokemon: state.pokemon![index] ,
                onPokemonPressed: (pokemon) => _onPokemonPressed(context,pokemon),
              );
            },
            itemCount: state.pokemon!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onPokemonPressed(BuildContext context, PokemonEntity pokemon) {
    Navigator.pushNamed(context, '/PokemonDetail', arguments: pokemon);
  }

  void _onShowSavedPokemonsViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedPokemon');
  }

  void _onSavePokemonClick(BuildContext context, PokemonEntity pokemonEntity) {
    BlocProvider.of<LocalPokemonBloc>(context).add(SavePokemon(pokemonEntity));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Pokemon saved successfully.'),
      ),
    );
  }
}