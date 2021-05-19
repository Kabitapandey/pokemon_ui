import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokemon_ui/pokemon.dart';
import 'package:pokemon_ui/pokemonDetail.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false, title: "Pokemon UI", home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");

  PokeHub pokehub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJSON = jsonDecode(res.body);
    pokehub = PokeHub.fromJson(decodedJSON);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: pokehub == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokehub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PokeDetail(
                                      pokemon: poke,
                                    )));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img)))),
                                  Text(poke.name,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList()),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
