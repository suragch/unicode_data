import 'package:unicode_data/unicode_data.dart';
import 'package:test/test.dart';

void main() {
  group('Scripts:', () {
    late List<Script> scripts;

    setUp(() {
      scripts = UnicodeScript.scripts;
    });

    test('scripts list contains data', () {
      expect(scripts, isNotEmpty);
    });

    test('scripts with the name Latin exist', () {
      final latinScrips = scripts.where((script) => script.name == 'Latin');
      expect(latinScrips, isNotEmpty);
    });

    test('find the script name for a code point', () {
      final codePoint = 'a'.runes.single;
      final found = scripts.where(
          (script) => codePoint >= script.start && codePoint <= script.end);
      expect(found, isNotNull);
      final scriptName = found.single.name;
      expect(scriptName, 'Latin');
    });

    test('find the category for a code point', () {
      final codePoint = 'a'.runes.single;
      final found = scripts.where(
          (script) => codePoint >= script.start && codePoint <= script.end);
      expect(found, isNotNull);
      final scriptName = found.single.category;
      expect(scriptName, 'L&');
    });

    test('find script ranges that are punctuation', () {
      final found = scripts.where((script) => script.category.startsWith('P'));
      expect(found, isNotEmpty);
    });
  });

  group('Blocks:', () {
    late List<Block> blocks;

    setUp(() {
      blocks = UnicodeBlock.blocks;
    });

    test('blocks list contains data', () {
      expect(blocks, isNotEmpty);
    });

    test('a block with the name Basic Latin exist', () {
      final block = blocks.where((block) => block.name == 'Basic Latin');
      expect(block, isNotEmpty);
    });

    test('find the block name for a code point', () {
      final codePoint = 'a'.runes.single;
      final found = blocks.where(
          (block) => codePoint >= block.start && codePoint <= block.end);
      expect(found, isNotNull);
      final blockName = found.single.name;
      expect(blockName, 'Basic Latin');
    });

    test('find block ranges that have CJK in the name', () {
      final found = blocks.where((block) => block.name.contains('CJK'));
      expect(found, isNotEmpty);
    });
  });
}
