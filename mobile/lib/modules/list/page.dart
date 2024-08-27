import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/home/page.dart';

import '../history_view/page.dart';
import 'controller.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  ListController controller = ListController();
  Future<void>? _future;

  @override
  void initState() {
    super.initState();
    _future = controller.start();
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

    // return List of histories
    return ListView.builder(
      itemCount: controller.histories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.histories[index].title),
          subtitle: Text(formatDate(controller.histories[index].date)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryView(historyId: controller.histories[index].id,),
              ),
            );
          },
        );
      },
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

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Lista de Histórias Criadas'),
          backgroundColor: Colors.transparent,
          elevation: 1,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            )],
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
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => Home(),
      //           ),
      //         );
      //       },
      //       child: const Text('Nova História'),
      //     ),
      //   ),
      // )
    );
  }
}

