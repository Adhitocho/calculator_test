import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var expression = "";
  var result = "";

  _calculate() {
    try {
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('%', '/100');

      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();

      setState(() {
        expression =
            exp.evaluate(EvaluationType.REAL, cm).toString().replaceAll(".0", "");
      });

    } catch (e) {
      print(e);
    }
  }

  _onButtonPressed(String text) {
    setState(() {
      if (text == '=') {
        _calculate();
      } else if (text == 'C') {
        setState(() {
          expression = '';
          result = '';
        });
      } else if (text == '<') {
        expression = expression.substring(0, expression.length - 1);
        if (expression.length == '0') {
          expression = '';
          result = '';
        }
      } else {
        setState(() {
          if (expression == '0') {
            expression = text;
          } else {
            expression += text;
          }
        });
      }
    });
  }

  Widget CalcButton(
    String btnText,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 65,
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: TextButton(
        onPressed: () => _onButtonPressed(btnText),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 25,
            color: Color(0xff555756),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 300,
                  alignment: Alignment.bottomRight,
                  child: Text(expression,
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w500), textAlign: TextAlign.right,),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          'C',
                          Colors.grey,
                        ),
                        CalcButton(
                          '%',
                          Colors.grey,
                        ),
                        CalcButton(
                          '<',
                          Colors.grey,
                        ),
                        CalcButton(
                          '/',
                          Colors.grey,
                        ),
                      ],
                    ), // Paling Atas
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          '7',
                          Colors.amber,
                        ),
                        CalcButton(
                          '8',
                          Colors.amber,
                        ),
                        CalcButton(
                          '9',
                          Colors.amber,
                        ),
                        CalcButton(
                          'x',
                          Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          '4',
                          Colors.amber,
                        ),
                        CalcButton(
                          '5',
                          Colors.amber,
                        ),
                        CalcButton(
                          '6',
                          Colors.amber,
                        ),
                        CalcButton(
                          '-',
                          Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          '1',
                          Colors.amber,
                        ),
                        CalcButton(
                          '2',
                          Colors.amber,
                        ),
                        CalcButton(
                          '3',
                          Colors.amber,
                        ),
                        CalcButton(
                          '+',
                          Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CalcButton(
                          '00',
                          Colors.white,
                        ),
                        CalcButton(
                          '0',
                          Colors.amber,
                        ),
                        CalcButton(
                          '.',
                          Colors.white,
                        ),
                        CalcButton(
                          '=',
                          Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               // Paling Bawah
            ],
          ),
        ),
      ),
    );
  }
}
