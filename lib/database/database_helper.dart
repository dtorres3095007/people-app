import 'dart:async';
import 'dart:io';
import 'package:people/models/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructure();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructure();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'people_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE people(id TEXT PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, lastName TEXT, date TEXT)",
    );
  }

  Future<List<Person>> getPeople() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('people');
    return List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'],
        name: maps[i]['name'],
        lastName: maps[i]['lastName'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> insertPerson(Person person) async {
    final Database db = await instance.database;
    await db.insert(
      'people',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(int id) async {
    final Database db = await instance.database;
    await db.delete(
      'people',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> update(Person person) async {
    final Database db = await instance.database;
    await db.update(
      'people',
      person.toMap(),
      where: "id = ?",
      whereArgs: [person.id],
    );
  }
}



// void main() async {

//   final database = openDatabase(
//     // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
//     // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
//     // construida para cada plataforma.
//     join(await getDatabasesPath(), 'people_database.db'),
//     // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar people
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT, lastName TEXT, date TEXT)",
//       );
//     },
//     // Establece la versión. Esto ejecuta la función onCreate y proporciona una
//     // ruta para realizar actualizacones y defradaciones en la base de datos.
//     version: 1,
//   );

//   Future<void> insert(Person person) async {
//     // Obtiene una referencia de la base de datos
//     final Database db = await database;

//     // Inserta el Person en la tabla correcta. También puede especificar el
//     // `conflictAlgorithm` para usar en caso de que el mismo Person se inserte dos veces.
//     // En este caso, reemplaza cualquier dato anterior.
//     await db.insert(
//       'people',
//       person.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Person>> people() async {
//     // Obtiene una referencia de la base de datos
//     final Database db = await database;

//     // Consulta la tabla por todos los Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('people');

//     // Convierte List<Map<String, dynamic> en List<Person>.
//     return List.generate(maps.length, (i) {
//       return Person(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         lastName: maps[i]['lastName'],
//         date: maps[i]['date'],
//       );
//     });
//   }

//   Future<void> update(Person person) async {
//     // Obtiene una referencia de la base de datos
//     final db = await database;

//     // Actualiza el Person dado
//     await db.update(
//       'people',
//       person.toMap(),
//       // Aseguúrate de que solo actualizarás el Person con el id coincidente
//        where: "id = ?",
//       // Pasa el id Person a través de whereArg para prevenir SQL injection
//       whereArgs: [person.id],
//     );
//   }

//   Future<void> delete(int id) async {
//     // Obtiene una referencia de la base de datos
//     final db = await database;

//     // Elimina el Person de la base de datos
//     await db.delete(
//       'people',
//       // Utiliza la cláusula `where` para eliminar un person específico
//        where: "id = ?",
//       // Pasa el id Person a través de whereArg para prevenir SQL injection
//       whereArgs: [id],
//     );
//   }
// }
