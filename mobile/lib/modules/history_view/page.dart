import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:story_craft_kids/modules/history_view/generate_pdf.dart';
import 'controller.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key, this.historyId}) : super(key: key);
  final int? historyId;

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryViewController controller = HistoryViewController();

  @override
  void initState() {
    controller.start(widget.historyId);
    super.initState();
  }

  List<Widget> buildTextImageList() {
    List<Widget> widgets = [];

    for (int i = 0; i < controller.dividedHistory.length; i++) {
      widgets.add(
        Text(
          controller.dividedHistory[i],
          style: const TextStyle(fontSize: 17.0),
        ),
      );

      if (i < controller.image_urls.length) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ImageNetwork(
              image: controller.image_urls[i]!,
              height: 400,
              width: 400,
              onLoading: const CircularProgressIndicator(
                color: Colors.indigoAccent,
              ),
              onError: const Icon(
                Icons.error,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          )
        );
      }
    }

    return widgets;
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
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ...buildTextImageList(),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  await generatePDF(controller);
                },
                icon: Icon(Icons.picture_as_pdf),
                label: Text('Gerar PDF'),
              ),
            ]
          ),
        ),
      ),
    );
  }

  _error() {
    return const Center(
      child: Text(
          'Erro ao carregar a página, verifique sua conexão com a internet.'),
    );
  }

  _start() {
    return Container();
  }

  stateManager(InfoStateHistoryView state) {
    if (state == InfoStateHistoryView.loading) {
      return _loading();
    } else if (state == InfoStateHistoryView.success) {
      return _success();
    } else if (state == InfoStateHistoryView.error) {
      return _error();
    } else {
      return _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('História'),
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, "/list", (route) => false);
          },
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
