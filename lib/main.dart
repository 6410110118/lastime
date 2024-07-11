import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/bloc_exports.dart';
import 'screens/tab_screen.dart';
import 'services/app_router.dart';
import 'services/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
  
}
class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({Key? key}) : super(key: key);

  @override
  _ExpansionPanelListExampleState createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 0,
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
          value: item.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
  });

  final int id;
  final String expandedValue;
  final String headerValue;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}