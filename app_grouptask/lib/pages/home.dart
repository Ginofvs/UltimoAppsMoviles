import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool Hoy = true, Tomorrow =false, ProximaSemana = false;
  bool suggest= false;
  TextEditingController todocontroller = new TextEditingController();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: (){
        openBox();
      },child:Icon(Icons.add, color: Color(0xFF249fff),size:30.0 ,)) ,
      body: Container(
        padding: EdgeInsets.only(top: 90.0, left: 30.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFF8C00),
              Color(0xFFFFA500),
              Color(0xFFFFD700)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            Text(
              "Hola\nGrupo 03 ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              " Iniciemos! ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Hoy = true;
                      Tomorrow = false;
                      ProximaSemana = false;
                    });
                  },
                  child: Material(
                    elevation: Hoy ? 5.0 : 0.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Hoy ? Color(0xFFFFA500) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Hoy",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Hoy = false;
                      Tomorrow = true;
                      ProximaSemana = false;
                    });
                  },
                  child: Material(
                    elevation: Tomorrow ? 5.0 : 0.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Tomorrow ? Color(0xFFFFA500) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Mañana",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Hoy = false;
                      Tomorrow = false;
                      ProximaSemana = true;
                    });
                  },
                  child: Material(
                    elevation: ProximaSemana ? 5.0 : 0.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: ProximaSemana ? Color(0xFFFFA500) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Próxima semana",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            CheckboxListTile(
              activeColor: Color(0xFF279cfb),
              title: Text("Realizar trabajo de Investigación",style:TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400),),
              value: suggest, onChanged: (newValue){
              setState(() {
                suggest = newValue!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            
            )

          ],
        ),
      ),
    );
  }
  Future openBox()=> showDialog(context: context, builder:(context) => AlertDialog(

  content: SingleChildScrollView(
child: Container(
child:Column (crossAxisAlignment: CrossAxisAlignment.start,
children: [
  Row(
    children: [
      GestureDetector(
        onTap: (){
      Navigator.pop(context);
        },
       child: Icon(Icons.cancel)
      ),
       SizedBox(width: 60.0,),
  Text("Añadir Tareas ",style:TextStyle(
    color: Color(0xff008080),
    fontWeight: FontWeight.bold),
  )
    ],
  ),
  SizedBox(height: 20.0,),
  Text("Nueva tarea"),
  SizedBox(height:10.0,),
  Container(
    padding: EdgeInsets.symmetric(horizontal:10.0),
    decoration: BoxDecoration(
      border:Border.all(
        color: Colors.black38,width: 2.0
      ), borderRadius: BorderRadius.circular(10)
    ), child: TextField(
      controller:todocontroller,
      decoration: InputDecoration(
        border: InputBorder.none, hintText: "Ingresar texto",
      ),

    ),
  ),
  SizedBox(height: 20.0,),
Center(
  child: Container(
  width: 100,
  padding: EdgeInsets.all(5),
  decoration: BoxDecoration(color: Color (0xFF008080),borderRadius: BorderRadius.circular(10),
  ),
    child:Center(child: Text("Añadir", style: TextStyle(color:Colors.white )))),
)
],)
),

  ),

  ));
  
}



