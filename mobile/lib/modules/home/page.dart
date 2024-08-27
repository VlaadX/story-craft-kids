import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/home/controller.dart';

import '../history_view/page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.start();
    super.initState();
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.lightBlueAccent,
        strokeWidth: 2.2,
      ),
    );
  }

  _success() {
    const List<String> api = ['open ai', 'gemini'];
    String dropDownValue = api.last;

    return Center(
      child: Form(
        key: controller.homeFormKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Título',
                              prefixIcon: Icon(Icons.title),
                            ),
                            onChanged: (value) {
                              controller.onChange(title: value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira um título';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Lugar',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            onChanged: (value) {
                              controller.onChange(place: value);
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nome do Personagem Principal',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onChanged: (value) {
                              controller.onChange(mainCharacter: value);
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Descrição Física do Personagem Principal',
                              prefixIcon: Icon(Icons.description),
                            ),
                            onChanged: (value) {
                              controller.onChange(mainCharacterDescription: value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira uma descrição, será importante para criar as imagens';
                              }
                              return null;
                            }
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Contexto',
                              prefixIcon: Icon(Icons.assignment),
                            ),
                            onChanged: (value) {
                              controller.onChange(context: value);
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Problema",
                              prefixIcon: Icon(Icons.error),
                            ),
                            onChanged: (value) {
                              controller.onChange(problem: value);
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Objetivo Final',
                              prefixIcon: Icon(Icons.check_circle),
                            ),
                            onChanged: (value) {
                              controller.onChange(mainGoal: value);
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Detalhes relavantes',
                              prefixIcon: Icon(Icons.info),
                            ),
                            onChanged: (value) {
                              controller.onChange(details: value);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Escolha a API para gerar a história',
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              value: dropDownValue ?? api.first,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });

                                controller.onChange(api: newValue);
                              },
                              items: api.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if(controller.homeFormKey.currentState!.validate()) {
                              int? historyId = await controller.createHistory();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HistoryView(
                                            historyId: historyId
                                        )
                                ),
                              );
                            }
                          },
                          label: const Text('Gerar História'),
                          icon: const Icon(Icons.generating_tokens_outlined),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        child: Text("Tente novamente"),
        onPressed: () {
          controller.start();
        },
      ),
    );
  }

  _start() {
    return Container();
  }

  stateManager(InfoStateList state) {
    if (state == InfoStateList.loading) {
      return _loading();
    } else if (state == InfoStateList.success) {
      return _success();
    } else if (state == InfoStateList.error) {
      return _error();
    } else {
      return _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar História'),
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: const BackButton(
          color: Colors.black,
        )
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // final height = constraints.maxHeight;
        // final _width = constraints.maxWidth;
        return ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (BuildContext context, value, Widget? child) {
            return stateManager(controller.state.value);
          },
        );
      }),
    );
  }
}

