class Token {
  final TokenType type;
  final String value;

  Token(this.type, this.value);
}

enum TokenType { number, operator, leftParen, rightParen, and, or, not }

class ExpressionParser {
  final String variable;

  ExpressionParser({this.variable = 'x'});

  bool evaluate(String expression, int variableValue) {
    String substitutedExpression =
        _substituteVariable(expression, variableValue);
    List<Token> tokens = _tokenize(substitutedExpression);
    return _evaluateExpression(tokens);
  }

  String _substituteVariable(String expression, int variableValue) {
    return expression.replaceAll(variable, variableValue.toString());
  }

  List<Token> _tokenize(String expression) {
    List<Token> tokens = [];
    RegExp regex = RegExp(r'(\d+|[<>=!]=?|&&|\|\||[()!])');

    for (Match match in regex.allMatches(expression)) {
      String value = match.group(0)!;
      TokenType type = _getTokenType(value);
      tokens.add(Token(type, value));
    }

    return tokens;
  }

  TokenType _getTokenType(String value) {
    if (RegExp(r'^\d+$').hasMatch(value)) return TokenType.number;
    if (['<', '>', '<=', '>=', '==', '!='].contains(value)) {
      return TokenType.operator;
    }
    if (value == '(') return TokenType.leftParen;
    if (value == ')') return TokenType.rightParen;
    if (value == '&&') return TokenType.and;
    if (value == '||') return TokenType.or;
    if (value == '!') return TokenType.not;
    throw FormatException('Invalid token: $value');
  }

  bool _evaluateExpression(List<Token> tokens) {
    if (tokens.isEmpty) throw FormatException('Empty expression');

    return _parseOr(tokens);
  }

  bool _parseOr(List<Token> tokens) {
    bool result = _parseAnd(tokens);
    while (tokens.isNotEmpty && tokens.first.type == TokenType.or) {
      tokens.removeAt(0);
      result = result || _parseAnd(tokens);
    }
    return result;
  }

  bool _parseAnd(List<Token> tokens) {
    bool result = _parseNot(tokens);
    while (tokens.isNotEmpty && tokens.first.type == TokenType.and) {
      tokens.removeAt(0);
      result = result && _parseNot(tokens);
    }
    return result;
  }

  bool _parseNot(List<Token> tokens) {
    if (tokens.isNotEmpty && tokens.first.type == TokenType.not) {
      tokens.removeAt(0);
      return !_parseNot(tokens);
    }
    return _parseComparison(tokens);
  }

  bool _parseComparison(List<Token> tokens) {
    if (tokens.first.type == TokenType.leftParen) {
      tokens.removeAt(0);
      bool result = _parseOr(tokens);
      if (tokens.isEmpty || tokens.first.type != TokenType.rightParen) {
        throw FormatException('Mismatched parentheses');
      }
      tokens.removeAt(0);
      return result;
    }

    if (tokens.length < 3) throw FormatException('Invalid comparison');

    int left = int.parse(tokens.removeAt(0).value);
    String op = tokens.removeAt(0).value;
    int right = int.parse(tokens.removeAt(0).value);

    switch (op) {
      case '<':
        return left < right;
      case '>':
        return left > right;
      case '<=':
        return left <= right;
      case '>=':
        return left >= right;
      case '==':
        return left == right;
      case '!=':
        return left != right;
      default:
        throw FormatException('Invalid operator: $op');
    }
  }
}
