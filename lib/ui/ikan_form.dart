import 'package:flutter/material.dart';
import 'package:responsi_wildan/model/ikan.dart';
import 'package:responsi_wildan/bloc/ikan_bloc.dart';
import 'package:responsi_wildan/ui/ikan_page.dart';
import 'package:responsi_wildan/widget/warning_dialog.dart';

class IkanForm extends StatefulWidget {
  Ikan? ikan;

  IkanForm({Key? key, this.ikan}) : super(key: key);

  @override
  State<IkanForm> createState() => _IkanFormState();
}

class _IkanFormState extends State<IkanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH IKAN";
  String tombolSubmit = "SIMPAN";

  final _namaTextboxController = TextEditingController();
  final _jenisTextboxController = TextEditingController();
  final _warnaTextboxController = TextEditingController();
  final _habitatTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.ikan != null) {
      setState(() {
        judul = "UBAH IKAN";
        tombolSubmit = "UBAH";
        _namaTextboxController.text = widget.ikan!.nama!;
        _jenisTextboxController.text = widget.ikan!.jenis!;
        _warnaTextboxController.text = widget.ikan!.warna!;
        _habitatTextboxController.text = widget.ikan!.habitat!;
      });
    } else {
      judul = "TAMBAH IKAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _jenisTextField(),
                _warnaTextField(),
                _habitatTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Ikan"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jenisTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jenis Ikan"),
      keyboardType: TextInputType.text,
      controller: _jenisTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _warnaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Warna Ikan"),
      keyboardType: TextInputType.text,
      controller: _warnaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Warna ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _habitatTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Habitat Ikan"),
      keyboardType: TextInputType.text,
      controller: _habitatTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Habitat ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.ikan != null) {
                //kondisi update
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Ikan createIkan = Ikan(id: null);
    createIkan.nama = _namaTextboxController.text;
    createIkan.jenis = _jenisTextboxController.text;
    createIkan.warna = _warnaTextboxController.text;
    createIkan.habitat = _habitatTextboxController.text;
    IkanBloc.addIkan(ikan: createIkan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Ikan updateIkan = Ikan(id: null);
    updateIkan.id = widget.ikan!.id;
    updateIkan.nama = _namaTextboxController.text;
    updateIkan.jenis = _jenisTextboxController.text;
    updateIkan.warna = _warnaTextboxController.text;
    updateIkan.habitat = _habitatTextboxController.text;
    IkanBloc.updateIkan(ikan: updateIkan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const IkanPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
