import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    obtenerGps();
    // obtenerGps().then((oPosition) {
    //   final double dLatitud = oPosition.latitude;
    //   final double dLongitud = oPosition.longitude;
    //   final String sUrl =
    //       'http://www.google.com/maps/place/$dLatitud,$dLongitud';
    //   abrirUrl(sUrl).then((_) {
    //     //La url se abrió correctamente
    //   }).catchError((oError) {
    //     //Ocurrió un error al abrir la url
    //   });
    // }).catchError((oError) {
    //   //Ocurrió un error al obtener la ubicación
    // });
  }

  Future<Position> obtenerGps() async {
    //Verificar si la ubicación del dispositivo está habilitada
    bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!bGpsHabilitado) {
      return Future.error('Por favor habilite el servicio de ubicación.');
    }
    //Validar permiso para utilizar los servicios de localización
    LocationPermission bGpsPermiso = await Geolocator.checkPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      bGpsPermiso = await Geolocator.requestPermission();
      if (bGpsPermiso == LocationPermission.denied) {
        return Future.error(
            'Se denegó el permiso para obtener la ubicación, por favor habilite el permiso e inténtelo de nuevo.');
      }
    }
    if (bGpsPermiso == LocationPermission.deniedForever) {
      return Future.error(
          'Se denegó el permiso para obtener la ubicación, por favor habilite el permiso manualmente e inténtelo de nuevo.');
    }
    //En este punto los permisos están habilitados y se puede consultar la ubicación
    return await Geolocator.getCurrentPosition();
  }

  Future<void> abrirUrl(final String sUrl) async {
    final Uri oUri = Uri.parse(sUrl);
    try {
      await launchUrl(oUri, mode: LaunchMode.externalApplication);
    } catch (oError) {
      return Future.error('No fue posible abrir la url: $sUrl.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: obtenerGps(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Ubicación obtenida correctamente.: https://www.google.com/maps/place/${snapshot.data!.latitude},${snapshot.data!.longitude}',
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final double dLatitud = snapshot.data!.latitude;
                          final double dLongitud = snapshot.data!.longitude;
                          final String sUrl =
                              'http://www.google.com/maps/place/$dLatitud,$dLongitud';
                          await abrirUrl(sUrl);
                        },
                        child: const Text('Abrir Google Maps')),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
