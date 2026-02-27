import 'package:flutter/material.dart';

class PokemonStarterScreen extends StatefulWidget {
  const PokemonStarterScreen({super.key});

  @override
  State<PokemonStarterScreen> createState() => _PokemonStarterScreenState();
}

Pokemon pokemonSelected = starters.first;

class _PokemonStarterScreenState extends State<PokemonStarterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PokeHeader("Escolha seu Pokémon Inicial"),
          PokemonCard(pokemon: pokemonSelected),
          PokemonOptionsList(
            options: starters,
            pokemonSelected: pokemonSelected,
            onSelected: (pokemon) {
              setState(() {
                pokemonSelected = pokemon;
              });
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const PokemonStarterApp());
}

class PokemonStarterApp extends StatelessWidget {
  const PokemonStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PokemonStarterScreen(),
    );
  }
}

class PokeHeader extends StatelessWidget {
  final String label;
  const PokeHeader(this.label, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      PokeHeader("Escolha seu Pokémon Inicial"),
      PokemonCard(pokemon: pokemonSelected),
    ],
  );
}

class Pokemon {
  final String name;
  final String image;
  const Pokemon({required this.name, required this.image});
}

const starters = [
  Pokemon(name: "Bulbasaur", image: "images/bulbassaur.png"),
  Pokemon(name: "Charmander", image: "images/charmander.png"),
  Pokemon(name: "Squirtle", image: "images/squirtle.png"),
];

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(pokemon.image, width: 250, height: 250),
        const SizedBox(height: 8),
        Text(
          pokemon.name.toUpperCase(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class PokemonOption extends StatelessWidget {
  final bool selected;
  final Pokemon pokemon;
  final Function(Pokemon) onSelected;
  const PokemonOption({
    super.key,
    required this.selected,
    required this.pokemon,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(pokemon),
      child: Column(
        children: [
          Image.asset(
            selected
                ? "images/pokeball_selected.png"
                : "images/pokeball_unselected.png",
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 4),
          Text(pokemon.name, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class PokemonOptionsList extends StatelessWidget {
  final List<Pokemon> options;
  final Pokemon pokemonSelected;
  final Function(Pokemon) onSelected;
  const PokemonOptionsList({
    super.key,
    required this.options,
    required this.pokemonSelected,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options.map((pokemon) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: PokemonOption(
            pokemon: pokemon,
            selected: pokemon == pokemonSelected,
            onSelected: onSelected,
          ),
        );
      }).toList(),
    );
  }
}
