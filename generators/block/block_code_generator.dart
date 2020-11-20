// This file is used to generate the list of blocks used in the UnicodeBlock class

import 'dart:convert';
import 'dart:io';

// create lines of text in the following format:
// Block(0x0590, 0x05FF, 'Hebrew'),
Future<void> main() async {

  // input
  final inputFile = File('generators/block/Blocks.txt');
  final fileText = await inputFile.readAsString();

  // output
  final outputFile = File('generators/block/output.txt');
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
    final endRegex = RegExp(r'^.+\.\.([0-9a-fA-F]+);');
    final endMatch = endRegex.firstMatch(line)!;
    final end = endMatch.group(1);

    // name
    final nameRegex = RegExp(r'; (.+)$');
    final nameMatch = nameRegex.firstMatch(line)!;
    final name = nameMatch.group(1);

    final outputLine = "Block(0x$start, 0x$end, '$name'),";
    await outputFile.writeAsString('$outputLine\n', mode: FileMode.append);

    print(outputLine);
  }
}
