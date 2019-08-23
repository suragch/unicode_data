import 'package:unicode_data/unicode_data.dart';

main() {
  unicodeBlockExamples();
  unicodeScriptExamples();
}

// Unicode Blocks
void unicodeBlockExamples() {
  // get a list of all blocks
  List<Block> blocks = UnicodeBlock.blocks;

  // find the block name for a code point
  final codePoint = 'a'.runes.single;
  final found = blocks
      .where((block) => codePoint >= block.start && codePoint <= block.end);
  final blockName = found.single.name; // Basic Latin

  // get the range for a specific block name
  final block = blocks.where((block) => block.name == 'Mongolian').single;
  final rangeStart = block.start; // 6144
  final rangeEnd = block.end; // 6319
}

// Unicode Scripts
void unicodeScriptExamples() {
  // get a list of all scripts
  List<Script> scripts = UnicodeScript.scripts;

  // find the script name and category for a code point
  final codePoint = 'a'.runes.single;
  final found = scripts.where(
      (script) => codePoint >= script.start && codePoint <= script.end);
  final script = found.single;
  final name = script.name; // Latin
  final category = script.category; // L&

  // find all script ranges for Latin
  final latinScripts = scripts.where((script) => script.name == 'Latin');

  // final all script ranges that are punctuation
  final punctRanges = scripts.where((script) => script.category.startsWith('P'));
}