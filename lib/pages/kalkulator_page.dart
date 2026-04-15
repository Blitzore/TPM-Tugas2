import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final TextEditingController _expressionController = TextEditingController();
  String _ekspresi = '';
  String _hasil = '0';

  bool _isOperator(String char) => char == '+' || char == '-';

  String _sanitizeExpression(String value) {
    final normalized = value.replaceAll(',', '.');
    final buffer = StringBuffer();
    bool hasDotInCurrentNumber = false;

    for (final char in normalized.split('')) {
      if (_isOperator(char)) {
        buffer.write(char);
        hasDotInCurrentNumber = false;
        continue;
      }

      if (char == '.') {
        if (hasDotInCurrentNumber) {
          continue;
        }
        hasDotInCurrentNumber = true;
        buffer.write(char);
        continue;
      }

      if (RegExp(r'[0-9]').hasMatch(char)) {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }

  bool _currentNumberHasDot() {
    for (int i = _ekspresi.length - 1; i >= 0; i--) {
      final char = _ekspresi[i];
      if (_isOperator(char)) return false;
      if (char == '.') return true;
    }
    return false;
  }

  @override
  void dispose() {
    _expressionController.dispose();
    super.dispose();
  }

  void _setExpression(String value) {
    _ekspresi = value;
    _expressionController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  void _onExpressionChanged(String value) {
    final sanitized = _sanitizeExpression(value);
    if (sanitized != value) {
      _setExpression(sanitized);
      setState(() {});
      return;
    }

    setState(() {
      _ekspresi = sanitized;
    });
  }

  void _onKeyTap(String key) {
    setState(() {
      if (key == 'C') {
        _setExpression('');
        _hasil = '0';
        return;
      }

      if (key == '⌫') {
        if (_ekspresi.isNotEmpty) {
          _setExpression(_ekspresi.substring(0, _ekspresi.length - 1));
        }
        return;
      }

      if (key == '=') {
        _hitungEkspresi();
        return;
      }

      if (_isOperator(key)) {
        if (_ekspresi.isEmpty) {
          if (key == '-') {
            _setExpression('-');
          }
          return;
        }

        final lastChar = _ekspresi[_ekspresi.length - 1];
        if (_isOperator(lastChar)) {
          if (lastChar == '+' && key == '-') {
            _setExpression(_ekspresi + key);
            return;
          }

          if (lastChar == '-' && _ekspresi.length >= 2) {
            final prevChar = _ekspresi[_ekspresi.length - 2];
            if (_isOperator(prevChar)) {
              _setExpression(
                _ekspresi.substring(0, _ekspresi.length - 2) + key,
              );
              return;
            }
          }

          _setExpression(_ekspresi.substring(0, _ekspresi.length - 1) + key);
          return;
        }
      }

      if (key == '.') {
        if (_ekspresi.isEmpty || _isOperator(_ekspresi[_ekspresi.length - 1])) {
          _setExpression('${_ekspresi}0.');
          return;
        }

        if (_currentNumberHasDot()) {
          return;
        }
      }

      _setExpression(_ekspresi + key);
    });
  }

  void _hitungEkspresi() {
    final result = _evaluatePlusMinusExpression(_ekspresi);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ekspresi tidak valid.'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _hasil = _formatDecimal(result);
    _setExpression(_hasil);
  }

  Decimal? _evaluatePlusMinusExpression(String rawExpression) {
    final expression = rawExpression.replaceAll(' ', '').replaceAll(',', '.');

    if (expression.isEmpty) return null;
    if (!RegExp(r'^[0-9+\-.]+$').hasMatch(expression)) return null;

    int index = 0;
    Decimal total = Decimal.zero;

    while (index < expression.length) {
      int sign = 1;

      while (index < expression.length && _isOperator(expression[index])) {
        if (expression[index] == '-') {
          sign *= -1;
        }
        index++;
      }

      if (index >= expression.length) return null;

      final numberBuffer = StringBuffer();
      bool hasDot = false;
      bool hasDigit = false;

      while (index < expression.length) {
        final char = expression[index];
        if (RegExp(r'[0-9]').hasMatch(char)) {
          numberBuffer.write(char);
          hasDigit = true;
          index++;
          continue;
        }

        if (char == '.') {
          if (hasDot) return null;
          hasDot = true;
          numberBuffer.write(char);
          index++;
          continue;
        }

        break;
      }

      if (!hasDigit) return null;

      final token = numberBuffer.toString();
      Decimal number;
      try {
        number = Decimal.parse(token);
      } catch (_) {
        return null;
      }

      total = sign == 1 ? total + number : total - number;

      if (index < expression.length &&
          expression[index] != '+' &&
          expression[index] != '-') {
        return null;
      }
    }

    return total;
  }

  String _formatDecimal(Decimal value) {
    String result = value.toString();
    if (!result.contains('.')) return result;
    result = result.replaceAll(RegExp(r'0+$'), '');
    result = result.replaceAll(RegExp(r'\.$'), '');
    return result.isEmpty ? '0' : result;
  }

  Widget _buildKey(String label, {Color? backgroundColor}) {
    return SizedBox(
      height: 64,
      child: ElevatedButton(
        onPressed: () => _onKeyTap(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Sederhana")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calculate_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Kalkulator (+ / -)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: _expressionController,
                            onChanged: _onExpressionChanged,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {
                              setState(() {
                                _hitungEkspresi();
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Masukkan ekspresi (+ / -)',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '= $_hasil',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: [
                        _buildKey(
                          'C',
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                        ),
                        _buildKey('⌫'),
                        _buildKey('+'),
                        _buildKey('-'),
                        _buildKey('7'),
                        _buildKey('8'),
                        _buildKey('9'),
                        _buildKey('='),
                        _buildKey('4'),
                        _buildKey('5'),
                        _buildKey('6'),
                        _buildKey('.'),
                        _buildKey('1'),
                        _buildKey('2'),
                        _buildKey('3'),
                        _buildKey('0'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Mendukung angka bulat, desimal, dan negatif (contoh: -3.5+12-0.25)",
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "Hasil",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectableText(
                      _hasil,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        letterSpacing: -1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
