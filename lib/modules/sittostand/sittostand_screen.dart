import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_view_model_example/modules/sittostand/sittostand_view_model.dart';
import 'package:riverpod_view_model_example/widgets/drawer.dart';
import 'package:riverpod_view_model_example/modules/sittostand/button_widget.dart';

class SitToStandScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        SitToStandScreenViewModel.provider.overrideWith((ref) {
          return SitToStandScreenViewModel(ref);
        }),
      ],
      child: _SitToStandScreen(),
    );
  }
}

class _SitToStandScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(SitToStandScreenViewModel.provider);
    final time = ref.watch(SitToStandScreenViewModel.counterProvider);
    final pretime = ref.watch(SitToStandScreenViewModel.preTimerProvider);
    final postTime = ref.watch(SitToStandScreenViewModel.postTimerProvider);

    final postTimeTime = ref.watch(SitToStandScreenViewModel.postCounterProvider);

    final preCounterProvider =
        ref.watch(SitToStandScreenViewModel.preCounterProvider);

    final isRunning = time == 60 ? false : true;
    final isPreRunning = pretime;

    final preWords = ["KÖR!", "Färdiga", "Klara", "Redo"];

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Sit to Stand - SCAPIS"),
      ),
      body: Column(
        
        children: <Widget>[
          Expanded(
            flex: 70, // 70% of the space
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Center(
                  child: pretime
                      ? SizedBox(
                          width: 450,
                          height: 450,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: (preCounterProvider / 3),
                                strokeWidth: 40,
                                color: Color.fromRGBO(31, 92, 139, 1.0),
                              ),
                              Center(
                                child: Text(
                                  preWords[preCounterProvider],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(31, 92, 139, 1.0),
                                      fontSize: 100
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : postTime ? 
                      SizedBox(
                          width: 450,
                          height: 450,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: (postTimeTime / 6),
                                strokeWidth: 40,
                                color: Color.fromRGBO(31, 92, 139, 1.0),
                              ),
                              const Center(
                                child: Text(
                                  "Sitt och vila",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(31, 92, 139, 1.0),
                                      fontSize: 60),
                                ),
                              )
                            ],
                          ),
                        ) :
                        SizedBox(
                              width: 350,
                              height: 350,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircularProgressIndicator(
                                    value: (time / 60),
                                    strokeWidth: 40,
                                    color: Color.fromRGBO(31, 92, 139, 1.0),
                                  ),
                                  Center(
                                    child: Text(
                                      time.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(31, 92, 139, 1.0),
                                          fontSize: 100),
                                    ),
                                  )
                                ],
                              ),
                            )
                        
                        
                        
                        
                        ),
            ),
          ),
          Expanded(
            flex: 15, // 15% of the space
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Center(
                  child: isRunning
                      ? ButtonWidget(
                          text: 'Börja om',
                          onClicked: () {
                            viewModel.stopTimer();
                          },
                        )
                      : isPreRunning ? 
                     const Text("") :
                       ButtonWidget(
                          text: 'Starta - Sit to Stand',
                          onClicked: () {
                            viewModel.preTimer();
                          },
                        ) 
                         
                     ),
            ),
          ),
          Expanded(
            flex: 15, // 15% of the space
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Center(child: Text("Skapad av Arbets- och miljömedicin Uppsala")),
            ),
          ),
        ],
      ),
    );
  }
}


//class _DarkModeCheckbox extends HookConsumerWidget {
//  @override
//  Widget build(BuildContext context, WidgetRef ref) {
//    final viewModel = ref.watch(PreferencesViewModel.provider);
//    return CheckboxListTile(
//      title: Text("Sit here to stand"),
//      value: ref.watch(viewModel.darkModeProvider),
//      onChanged: viewModel.setDarkmode,
//    );
//  }
//}
