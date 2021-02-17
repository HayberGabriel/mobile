import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lojavirtual/common/login_card.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/reset_password/reset_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
final User user = User();
class _ProfileScreenState extends State<ProfileScreen> {
  String url =
      'https://w7.pngwing.com/pngs/860/503/png-transparent-computer-icons-person-pion-black-desktop-wallpaper-share-icon.png';
  bool isPasswordTextField = true;
  bool showPassword = true;
  String nome = 'default';
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        /* if(showsnackbar == true) {
                        const snack = SnackBar(content: Text(
                        'Dados salvos com sucesso!',
                        style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.black,
                        duration: Duration(seconds: 2),
                      );
                      Scaffold.of(context).showSnackBar(snack);
                      }*/
      ),
      body: Consumer<UserManager>(builder: (_, userManager, __) {
        if (userManager.user == null) {
          return LoginCard();
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    ImagePicker.pickImage(source: ImageSource.camera)
                        .then((file) {
                      if (file == null) return;
                      setState(() {
                        url =
                        'https://image.freepik.com/vetores-gratis/perfil-de-avatar-de-homem-no-icone-redondo_24640-14044.jpg';
                      });
                    });
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage('$url')),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey2,
                  child:
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: '${userManager.user.name}',
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(Icons.person_outline),
                    ),
                    enabled: !userManager.loading,
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Nenhuma mudança foi feita';
                      else if (name.trim().split(' ').length <= 1)
                        return 'Preencha um nome válido';
                      else{
                        return null;
                      }
                    },
                    onSaved: (name) => nome = name,
                  ),),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${userManager.user.email}',
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(Icons.alternate_email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !userManager.loading,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '(85)99999-9999',
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(Icons.phone_android),
                  ),
                  keyboardType: TextInputType.phone,
                  enabled: !userManager.loading,
                ),


                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed:userManager.loading ? null : () {
                      if (formKey2.currentState.validate()) {
                        formKey2.currentState.save();
                        scaffoldKey2.currentState.showSnackBar(
                          const SnackBar(
                            content: Text('Nome Salvo com Sucesso'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        Firestore.instance.document('users/${userManager.user.id}').updateData(
                            {'name': '$nome'}
                        );
                        setState(() {
                          userManager.user.name = nome;
                        });
                        /*showDialog(
                                  context: context,
                                  builder: (context)=> AlertDialog(
                                    title: Text('Tem certeza que deseja alterar seus dados?'),
                                    content: Text('A ação não poderá ser desfeita'),
                                    actions: [
                                      FlatButton(onPressed: (){

                                        Navigator.pop(context);
                                      },
                                          child: Text('Sim')),
                                      FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancelar'))
                                    ],
                                  ));*/
                      }
                      debugPrint('${userManager.user.id}');
                    },
                    child: const Text(
                      'Atualizar Nome',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ResetScreen()));
                    },
                    child: const Text(
                      'Redefinir Senha',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ])),
        );
      }),
    );
  }
}
