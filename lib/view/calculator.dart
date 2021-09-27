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
  List<String> history = [];

  _calculate() {
    try {
      history.add(expression);
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

  Widget calcButton({
    required String btnText,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.all(10),
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
          style: const TextStyle(
            fontSize: 25,
            color: Color(0xff555756),
          ),
        ),
      ),
    );
  }

  Widget renderHistory() {
    if(history.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        height: 50,
        child: ListView(
          shrinkWrap: false,
          children: history.map((e) => Text(e, textAlign: TextAlign.end,)).toList(),
        ),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              renderHistory(),
              Container(
                width: 300,
                alignment: Alignment.bottomRight,
                child: Text(expression,
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.w500), textAlign: TextAlign.right,),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calcButton(
                          btnText: 'C',
                          color: Colors.grey,
                        ),
                        calcButton(
                          btnText:'%',
                          color:Colors.grey,
                        ),
                        calcButton(
                          btnText:'<',
                          color:Colors.grey,
                        ),
                        calcButton(
                          btnText:'/',
                          color:Colors.grey,
                        ),
                      ],
                    ), // Paling Atas
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calcButton(
                          btnText:'7',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'8',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'9',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'x',
                          color:Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calcButton(
                          btnText:'4',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'5',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'6',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'-',
                          color:Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calcButton(
                          btnText:'1',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'2',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'3',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'+',
                          color:Colors.grey,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calcButton(
                          btnText:'00',
                          color:Colors.white,
                        ),
                        calcButton(
                          btnText:'0',
                          color:Colors.amber,
                        ),
                        calcButton(
                          btnText:'.',
                          color:Colors.white,
                        ),
                        calcButton(
                          btnText:'=',
                          color:Colors.grey,
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
