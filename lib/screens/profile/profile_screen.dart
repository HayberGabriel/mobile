import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lojavirtual/common/login_card.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String url = 'https://w7.pngwing.com/pngs/860/503/png-transparent-computer-icons-person-pion-black-desktop-wallpaper-share-icon.png';
  bool isPasswordTextField = true;
  bool showPassword=true;
  bool showsnackbar = false;
  String nome = 'Pessoa1';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
    appBar: AppBar(
    centerTitle: true,
    title: const Text(
    'Perfil', style: TextStyle(color: Colors.white),
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
    body:
      Consumer<UserManager>(
        builder: (_, userManager, __){
          if(userManager.user == null){
            return LoginCard();
          }
      return  GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
                padding: EdgeInsets.all(15.0),
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 15,),
                      GestureDetector(
                        onTap: (){
                          ImagePicker.pickImage(source: ImageSource.camera).then((file){
                            if(file == null) return ;
                            setState(() {
                              url = 'https://image.freepik.com/vetores-gratis/perfil-de-avatar-de-homem-no-icone-redondo_24640-14044.jpg';
                            });
                          });
                        },
                        child: Stack(
                            children: <Widget>[Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage
                                      ('$url')
                                ),
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
                            ]
                        ),
                      ),

                      SizedBox(height: 15,),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Nome',
                          hintText: '${userManager.user.name}',
                          hintStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.person_outline),
                        ),

                        onChanged: (text){
                        },
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'E-mail',
                          hintText: '${userManager.user.email}',
                          hintStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text){},
                      ),
                      TextField(
                        decoration: InputDecoration(
                            suffixIcon: isPasswordTextField
                                ? IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.grey,
                              ),
                            )
                                : null,
                            labelText: 'Alterar Senha',
                            hintText: '********',
                            icon: Icon(Icons.lock_outlined)),
                        onChanged: (text){},
                        obscureText: showPassword,
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)=> AlertDialog(
                                    title: Text('Tem certeza que deseja alterar seus dados?'),
                                    content: Text('A ação não poderá ser desfeita'),
                                    actions: [
                                      FlatButton(onPressed: (){
                                        showsnackbar = true;
                                        Navigator.pop(context);
                                      },
                                          child: Text('Sim')),
                                      FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancelar'))
                                    ],
                                  ));
                            },
                            child:
                            const Text(
                              'Atualizar Dados',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                              ),
                            ),
                            ),
                      ),
                    ]
                )),
          );
  }),
    );
  }
}
