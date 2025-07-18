import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  String name = context.vars['name'] as String;

  // add export reference to models
  File modelsFile = File('lib/data/models/models.dart');
  modelsFile.writeAsStringSync(
    "export '${name.snakeCase}.dart';",
    mode: FileMode.append,
  );

  // create repository
  if (context.vars['repository']) {
    File repositoriesFile = File('lib/data/repositories/repositories.dart');
    repositoriesFile.writeAsStringSync(
      "export 'interfaces/${name.snakeCase}_repository.dart';\n",
      mode: FileMode.append,
    );
    repositoriesFile.writeAsStringSync(
      "export '${name.snakeCase}_repository.dart';\n",
      mode: FileMode.append,
    );

    File tablesFile = File('lib/data/tables/tables.dart');
    tablesFile.writeAsStringSync(
      "export '${name.snakeCase}_table.dart';\n",
      mode: FileMode.append,
    );

    String text = "";
    String pattern = "";

    // add scheme to database
    File file = File('lib/data/database.dart');
    text = file.readAsStringSync();
    pattern = r"(tables:\s*\[[^\]]*?,\s*)()(\])";
    text = text.replaceAllMapped(RegExp(pattern), (match) => "${match.group(1)}\n${name.pascalCase}Table,${match.group(3)}");
    file.writeAsStringSync(text);
  }

  // format the code and run the build_runner
  Process.runSync("dart", ["format", "lib/data"]);
  //Process.runSync("dart", ["run", "build_runner", "build"]);
}
