import 'package:flutter/material.dart';
// new commit
void main() {
  runApp(
    MaterialApp(
      home: Calculator(),
    ),
  );
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';
  String currentInput = '';
  String operand = '';
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CalcyUI(
              display: display,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 50,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: buttons.map((button) {
                return CalculatorButton(
                  button: button,
                  onPressed: () {
                    oprationPerformed(button);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void oprationPerformed(ButtonModel button) {
    setState(() {
      if (button.buttonType == ButtonType.digits) {
        currentInput += button.value;
        display = currentInput;
      }else if(button.buttonType == ButtonType.operator){
        if(currentInput.isNotEmpty){
          if(operand.isEmpty){
            result = double.parse(currentInput);
          }else{
            performedOperation();
          }
          operand = button.value;
          currentInput = '';
        }
      }else if(button.buttonType == ButtonType.clear){
        display = '';
        operand = '';

        result = 0;
        currentInput = '';
      }else if(button.buttonType== ButtonType.equal){
        if(currentInput.isNotEmpty && operand.isNotEmpty){
          performedOperation();
        }
      }
    });
  }

  void performedOperation() {
    switch(operand){
      case '+':
        result += double.parse(currentInput);
      case '-':
        result -= double.parse(currentInput);
      case '*':
        result *= double.parse(currentInput);


    }
    display = result.toString();
    currentInput = '';
  }
}

List<ButtonModel> buttons = [
  ButtonModel(value: '0', buttonType: ButtonType.digits),
  ButtonModel(value: '1', buttonType: ButtonType.digits),
  ButtonModel(value: '2', buttonType: ButtonType.digits),
  ButtonModel(value: '+', buttonType: ButtonType.operator),
  ButtonModel(value: '-', buttonType: ButtonType.operator),
  ButtonModel(value: '*', buttonType: ButtonType.operator),
  ButtonModel(value: '=', buttonType: ButtonType.equal),
  ButtonModel(value: 'C', buttonType: ButtonType.clear),
];

class CalcyUI extends StatelessWidget {
  const CalcyUI({super.key, required this.display});

  final String display;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.brown,
      ),
      alignment: Alignment.center,
      child: Text(
        display,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key, required this.button, required this.onPressed});

  final void Function() onPressed;
  final ButtonModel button;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.brown,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          button.value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

enum ButtonType { operator, digits, clear, equal }

class ButtonModel {
  String value;
  ButtonType buttonType;

  ButtonModel({required this.value, required this.buttonType});
}
