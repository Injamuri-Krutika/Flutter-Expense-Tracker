import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;
  ChartBar(this.label, this.spendingAmount, this.spendingPercentage);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 15,
          child: Column(
            children: <Widget>[
              Text(
                label,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // SizedBox(width: 40),
        Column(children: <Widget>[
          Container(
              width: 200,
              height: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              )),
        ]),
        // SizedBox(width: 40),
        Container(
          width: 70,
          child: Column(
            children: <Widget>[
              FittedBox(child: Text(spendingAmount.toStringAsFixed(0)))
            ],
          ),
        ),
      ],
    );
  }
}
