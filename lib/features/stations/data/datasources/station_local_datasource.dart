import '../../../../core/database/database_helper.dart';
import '../models/station_model.dart';

class StationLocalDataSource {
  //Asynchronní získaní všech stanic z lokální databáze
  Future<List<StationModel>> getAllStations() async {
    final db = await DatabaseHelper.database;
    final result = await db.query("Bod");
    return result.map((e) => StationModel.fromMap(e)).toList();
  }

  //Asynchronní vyhledání stanic podle dotazu v lokální databázi
  Future<List<StationModel>> searchStations(String query) async {
    final db = await DatabaseHelper.database;
    final result = await db.query(
      "Bod",
      where: "Nazev LIKE ?",
      whereArgs: ['%$query%'],
    );
    return result.map((e) => StationModel.fromMap(e)).toList();
  }
}
