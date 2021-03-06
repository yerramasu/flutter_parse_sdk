import 'package:flutter/material.dart';
import 'package:flutter_plugin_example/application_constants.dart';
import 'package:flutter_plugin_example/diet_plan.dart';
import 'package:parse_server_sdk/parse.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initParse();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running Parse init'),
        ),
        floatingActionButton:
            new FloatingActionButton(onPressed: runTestQueries),
      ),
    );
  }

  initParse() async {
    // Initialize parse
    Parse().initialize(ApplicationConstants.keyParseApplicationId,
        ApplicationConstants.keyParseServerUrl,
        masterKey: ApplicationConstants.keyParseMasterKey,
        appName: ApplicationConstants.keyAppName,
        debug: true);

    // Check server is healthy and live - Debug is on in this instance so check logs for result
    var response = await Parse().healthCheck();
    if (response.success){
      runTestQueries();
    } else {
      print("Server health check failed");
    }
  }

  runTestQueries() {
    createItem();
    getAllItems();
    getAllItemsByName();
    getSingleItem();
    query();
    function();
    initUser();
  }

  void createItem() async {

    var newObject = ParseObject('TestObjectForApi');
    newObject.set<String>('name', 'testItem');
    newObject.set<int>('age', 26);

    var apiResponse = await newObject.create();

    if (apiResponse.success && apiResponse.result != null) {
        print(ApplicationConstants.keyAppName + ": " + apiResponse.result.toString());
    }
  }

  void getAllItemsByName() async {
    var apiResponse = await ParseObject('ParseTableName').getAll();

    if (apiResponse.success && apiResponse.result != null) {
      for (var testObject in apiResponse.result) {
        print(ApplicationConstants.keyAppName + ": " + testObject.toString());
      }
    }
  }

  void getAllItems() async {
    var apiResponse = await DietPlan().getAll();

    if (apiResponse.success && apiResponse.result != null) {
      for (var plan in apiResponse.result) {
        print(ApplicationConstants.keyAppName + ": " + (plan as DietPlan).name);
      }
    } else {
      print(ApplicationConstants.keyAppName + ": " + apiResponse.error.message);
    }
  }

  void getSingleItem() async {
    var apiResponse = await DietPlan().getObject('R5EonpUDWy');

    if (apiResponse.success && apiResponse.result != null) {
      var dietPlan = (apiResponse.result as DietPlan);

      // Shows example of storing values in their proper type and retrieving them
      dietPlan.set<int>('RandomInt', 8);
      var randomInt = dietPlan.get<int>('RandomInt');

      if (randomInt is int) print('Saving generic value worked!');

      // Shows example of pinning an item
      dietPlan.pin();

      // shows example of retrieving a pin
      var newDietPlanFromPin = DietPlan().fromPin('R5EonpUDWy');

      if (newDietPlanFromPin != null) print('Retreiving from pin worked!');

    } else {
      print(ApplicationConstants.keyAppName + ": " + apiResponse.error.message);
    }
  }

  void query() async {
    var queryBuilder = QueryBuilder<DietPlan>(DietPlan())
      ..greaterThan(DietPlan.keyFat, 20)
      ..descending(DietPlan.keyFat);

    var apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.result != null) {
      print("Result: ${((apiResponse.result as List<dynamic>).first as DietPlan).toString()}");
    } else {
      print("Result: ${apiResponse.error.message}");
    }
  }

  initUser() async {

   // All return type ParseUser except all
    var user = ParseUser("TestFlutter", "TestPassword123", "TestFlutterSDK@gmail.com");
    user = await user.signUp();
    user = await user.login();
    user = null;

    // Best practice for starting the app. This will check for a
    user = ParseUser.currentUser();
    user = await user.getCurrentUserFromServer();
    user = await user.requestPasswordReset();
    user = await user.verificationEmailRequest();

    user = await user.save();
    var destroyResponse = await user.destroy();
    if (destroyResponse.success) print('object has been destroyed!');

    // Returns type ParseResponse as its a query, not a single result
    await ParseUser.all();
  }

  function() {
    var function = ParseCloudFunction('testFunction');
    function.execute();
  }
}
