import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//crio a classe TransactionForm como stateless
class  TransactionForm extends StatefulWidget {
  //int cont = 0;

  
 
    /*
    TransactionForm.contador({int cont = 0}) {
      this.cont = cont;
    }
    */
   
    late void Function(String title, double valor, DateTime) onSubmit;
   
    //passo a função onSubmit como parametro para o construtor
    TransactionForm.onSubmit(this.onSubmit);
      //this.onSubmit = onSubmit;
    //}

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
    //crio as variaveis
    final titleController = TextEditingController();
    final valueController = TextEditingController();
    DateTime? _selectedDate = DateTime.now();

      //var cont;
    _submitForm() {
       final title = titleController.text;
       final value = double.tryParse(valueController.text) ?? 0.0;
       
       if(title.isEmpty || value <= 0 || _selectedDate == null){
        return;
       }
       widget.onSubmit(title, value, _selectedDate!);
       //cont++;
       //print(widget.cont);                             
    }  

    _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
      ).then((pickedDate) {
        if(pickedDate == null) {
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card( //A classe retorna um card
                  elevation: 5, //essa função elevation cria um aspecto de caixa no widget
                  child: Padding(                       
                    padding: const EdgeInsets.all(10),   
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: titleController,
                          onSubmitted: (value) => _submitForm(),
                          decoration: const InputDecoration(
                            labelText: 'Título',
                          ),
                        ),
                        TextField(
                          controller: valueController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onSubmitted: (value) => _submitForm(),
                          decoration: const InputDecoration(
                            labelText: 'Valor (R\$)',
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _selectedDate == null ? 'Nenhuma data selecionada'
                                  : DateFormat('dd/MM/y').format(_selectedDate!),
                                  
                                  ),
                              ),
                              TextButton(
                                child: const Text(
                                  'Selecionar Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                onPressed: _showDatePicker,
                              )  
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text(
                                'Nova transação',
                                style: TextStyle(
                                color: Colors.white,
                                ),
                                ),
                            ),
                            
                          ],
                        )
                    ],
                    ),
                  ),
                  
                ),
      ],
  
  );
            
  }
}
  