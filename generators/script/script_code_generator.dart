// This file is used to generate the list of scripts used in the UnicodeScript class

import 'dart:convert';
import 'dart:io';

// create lines of text in the following format:
// Script(0xD7CB, 0xD7FB, 'Hangul', 'Lo'),
void main() async {

  // input
  final inputFile = File('generators/script/Scripts.txt');
  final fileText = await inputFile.readAsString();

  // output
  final outputFile = File('generators/script/output.txt');
  if (await outputFile.exists()) {
    await outputFile.delete();
  }

  // loop through each line in the string
  // ignore comments or empty lines
  final ls = LineSplitter();
  final lines = ls.convert(fileText);
  for (var line in lines) {
    if (line.trim() == '' || line.startsWith('#')) {
      continue;
    }

    // start
    final startRegex = RegExp(r'^[0-9a-fA-F]+');
    final startMatch = startRegex.firstMatch(line)!;
    final start = startMatch.group(0);

    // end
    final endRegex = RegExp(r'^.+\.\.([0-9a-fA-F]+).+;');
    final endMatch = endRegex.firstMatch(line);
    final end = endMatch?.group(1) ?? start;

    // script property value (ie, name)
    final nameRegex = RegExp(r'; (\w+) #');
    final nameMatch = nameRegex.firstMatch(line)!;
    final name = nameMatch.group(1);

    // category
    final categoryRegex = RegExp(r'; .+ # (.{2})');
    final categoryMatch = categoryRegex.firstMatch(line)!;
    final category = categoryMatch.group(1);

    final outputLine = "Script(0x$start, 0x$end, '$name', '$category'),";
    await outputFile.writeAsString('$outputLine\n', mode: FileMode.append);

    print(outputLine);
  }
}
