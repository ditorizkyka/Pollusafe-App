import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pollusafe_app/src/core/model/MapModel.dart';

TileOverlay createTileOverlay() {
  return TileOverlay(
    tileOverlayId: const TileOverlayId('aqiTileOverlay'),
    tileProvider: MapModel(),
  );
}
