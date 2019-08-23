# Unicode Data

This library puts Unicode data in a format that can be programmatically manipulated. The current implementation includes Unicode blocks and scrips data.

## Background

Unicode code points are divided into code blocks that generally contains characters within the same or related writing systems. For example [Basic Latin](https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)) or [Arabic](https://en.wikipedia.org/wiki/Arabic_(Unicode_block)). However, the complete character set needed for a writing system is often spread across a number of code blocks. This character set is referred to as a script. If you want to know what writing system a particular character belongs to, it is generally more accurate to use the Unicode script data rather than the block data. You can read more about the difference [here](http://www.unicode.org/reports/tr24/#Scripts_and_Blocks).

This library contains classes for Unicode scripts and blocks. It was generated from the Unicode 12.0 [Scripts.txt](https://www.unicode.org/Public/12.0.0/ucd/Scripts.txt) and [Blocks.txt](https://www.unicode.org/Public/12.0.0/ucd/Blocks.txt) data files. This library is exhaustive in that it includes every script and block in those data files.

## Usage

A simple usage example:

```dart
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
```

The [category](http://www.unicode.org/reports/tr44/#General_Category_Values) is the type of character that it is, whether a letter, punctuation or some other type.

## Contributing

Your help and pull requests are welcome.

- When there is a new Unicode version, the code should be regenerated from the data files. See the `generators` folder in the source code.
- Because there is so much data in the list, it can be potentially expensive to query the list. I would appreciate advice or examples on how to do this more efficiently. Or I am open to using a different data structure.
- There are other types of Unicode data that could be included in this library in the future. You can open an issue if you have a request.
