  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:namer_app/Cubit/CounterCubit.dart';
  import 'package:namer_app/Cubit/ThemeCubit.dart';

  class CounterScreen extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        backgroundColor: Colors.deepPurple.shade100,

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Counter Value:", style: TextStyle(fontSize: 18)),
                BlocBuilder<CounterCubit, int>(
                  builder: (context, count) {
                    return Text("$count", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "decrement",
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: "increment",
                      onPressed: () => context.read<CounterCubit>().increment(),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
      );
    }
  }
