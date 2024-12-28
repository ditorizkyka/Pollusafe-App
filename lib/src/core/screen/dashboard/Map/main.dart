import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollusafe_app/src/constant/constant.dart';
import 'package:pollusafe_app/src/constant/themes/sizes.dart';
import 'package:pollusafe_app/src/core/controller/UserController.dart';
import 'package:pollusafe_app/src/core/model/MapModel.dart';
import 'package:pollusafe_app/src/core/model/UserModel.dart';
import 'package:pollusafe_app/src/core/screen/auth/signup/signup.dart';
import 'package:pollusafe_app/src/core/screen/data/fetch/search_cities.dart';
import 'package:pollusafe_app/src/widgets/button/button_app.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  TextEditingController searchController = TextEditingController();
  GoogleMapController? _mapController;

  // Membuat TileOverlay dengan TileProvider kustom

  void _updateCameraPosition(double lat, double lng) {
    final newPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 11.0, // Sesuaikan dengan tingkat zoom yang diinginkan
    );

    _mapController?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorApp.green,
                Color.fromARGB(255, 10, 88, 68),
              ],
            ),
          ),
        ),
        title: Text(
          "Maps",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: SizeApp.h20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => Stack(children: [
          GoogleMap(
            // liteModeEnabled: true, // Mode lebih ringan
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  userController.userModel.value?.latitude ??
                      userController.defaultLat.value,
                  userController.userModel.value?.longitude ??
                      userController.defaultLong.value),
              zoom: 11.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            tileOverlays: {
              UserModel().displayMap(),
            },
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeApp.h20,
                  vertical: SizeApp.h16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Find your area",
                              hintStyle: TextStyle(
                                  color: ColorApp.darkGrey,
                                  fontSize: SizeApp.h16),
                              prefixIcon: const Icon(Icons.search,
                                  color: ColorApp.darkBlue),
                              labelStyle: GoogleFonts.roboto(
                                fontSize: SizeApp.h16,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 238, 240, 244),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(SizeApp.h12),
                                ),
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {});
                            },
                          ),
                        ),
                        Gap.w12,
                        IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (searchController.text == "") {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialogApp(
                                        title: "Cannot find empty city!",
                                        description:
                                            " Please enter a valid city name."));
                              } else {
                                if (SearchCities.fetchGeo(
                                                searchController.text)!
                                            .lat !=
                                        0 &&
                                    SearchCities.fetchGeo(
                                                searchController.text)!
                                            .long !=
                                        0) {
                                  _updateCameraPosition(
                                      MapModel()
                                          .setDatabySearch(
                                              searchController.text)
                                          .latitude_city!,
                                      MapModel()
                                          .setDatabySearch(
                                              searchController.text)
                                          .longitude_city!);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialogApp(
                                          title: "City Not Found!",
                                          description:
                                              "Please enter a valid city name."));
                                }
                              }
                            },
                            icon: const Icon(Icons.send))
                      ],
                    ),
                    Gap.h12,
                    ButtonApp(
                      onPressed: () {
                        _updateCameraPosition(
                          userController.userModel.value?.latitude ??
                              userController.defaultLat.value,
                          userController.userModel.value?.longitude ??
                              userController.defaultLong.value,
                        );
                      },
                      text: "Current Location",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
