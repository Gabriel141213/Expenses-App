import 'package:flutter/material.dart';
import 'package:login/models/transaction.dart';
import 'package:intl/intl.dart';

//crio a classe stateless TransactionList 
class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;
  //crio o construtor padrão da classe e defino a classe transictions como parametro
  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(
     children: <Widget>[
       Text('Nenhuma transação cadastrada!',
       style: Theme.of(context).textTheme.subtitle1,
       ),
       SizedBox(height: 20),
       Container(
         height: 200,
         child: Image.asset(
           'assets/images/ZZZicon.png',
           fit: BoxFit.cover,
         ),
       ),
     ],
    ): ListView.builder(
           itemCount: transactions.length,
           itemBuilder:(context, index) {
             final tr = transactions[index];
               return Card(
                 child: ListTile(
                   leading: CircleAvatar(
                     radius: 30,
                     child: Padding(
                       padding: const EdgeInsets.all(6),
                       child: FittedBox(
                         child: Text('R\$${tr.value}'),
                       ),
                     ),
                   ),
                   title: Text(
                     '${tr.title}',
                     style: Theme.of(context).textTheme.subtitle1,
                   ),
                   subtitle: Text(
                     DateFormat('d MM y').format(tr.date),
                   ),
                   trailing: IconButton(
                     icon: Icon(Icons.delete),
                     color: Colors.red,
                     onPressed: () => onRemove(tr.id), 
                     ),
                 )
               );
             
             });
     
    
  }
}