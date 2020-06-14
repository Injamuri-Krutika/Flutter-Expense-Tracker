import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentage);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: constraints.maxWidth * 0.10,
            child: Column(
              children: <Widget>[
                FittedBox(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.05,
          ),
          Column(children: <Widget>[
            Container(
                width: constraints.maxWidth * 0.7,
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
          SizedBox(
            width: constraints.maxWidth * 0.05,
          ),
          Container(
            width: constraints.maxWidth * 0.10,
            child: Column(
              children: <Widget>[
                FittedBox(child: Text(spendingAmount.toStringAsFixed(0)))
              ],
            ),
          ),
        ],
      );
    });
  }
}
