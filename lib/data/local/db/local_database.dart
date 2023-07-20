import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:third_exam_n8/data/models/product_model/product_model.dart';
import '../../models/product/product.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }


  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("products.db");
      return _database!;
    }
  }




  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute("""
    CREATE TABLE favourites(
    product_id INT NOT NULL
    );
    """);
    await db.execute("""
    CREATE TABLE basket(
    product_id INT NOT NULL,
    count INT default 0
    );
    """);
    await db.execute('''
      CREATE TABLE products(
        productId TEXT PRIMARY KEY,
        count INTEGER,
        name TEXT,
        price REAL,
        imageUrl TEXT,
        isLiked INTEGER,
        isCarted INTEGER
      )
    ''');
  }


//-----------------------favourite------------------------------
  static Future<List> getAll() async {
    final db = await getInstance.database;
    final listOfID = await db.query('favourites',
        columns: ['product_id']);
    return listOfID.map((e) => e['product_id']).toList();
  }

  static deleteByID(int id) async {
    final db = await getInstance.database;
    await db.delete('favourites' ,
        where: 'product_id = ?', whereArgs: [id]);
  }

  static insert(ProductModel product) async {
    final db = await getInstance.database;
    List ids = await getAll();
    (ids.contains(product.id))
        ? await deleteByID(product.id)
        : await db.insert( 'favourites' , {
      "product_id": product.id,
    });

  }

  //-------------------------------------------------------------

  static insertCountData(ProductModel productModel) async {
    final db = await getInstance.database;
    List ids = (await getAllFromBasket() as List).map((e) => e['product_id']).toList(

    );
    List result =await getById(productModel.id);
  ids.map((e) => e).toList().contains(productModel.id)
        ? await increaseCount(productModel.id,result[0]['count'])
        : await db.update('basket', {
      "product_id": productModel.id, 'count':1,
    });
  }
  static Future<void> insertProduct(Product product) async {
    final db = await getInstance.database;
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }
  Future<Product?> getProductById(String productId) async {
    final db = await getInstance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Product>> getAllProducts() async {
    final db = await getInstance.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  static getById(int id) async {
    final db = await getInstance.database;
    return await db.query('basket',where: 'product_id = ?',whereArgs: [id]);
  }

  static getAllFromBasket() async {
    final db = await getInstance.database;
    final baskets =  await db.query('basket');
    return baskets.map((e) => e).toList();
  }


  static increaseCount(int id,int count) async {
    final db = await getInstance.database;
    await db.update('basket', {'count':count++});
  }

  static Future<void> updateProduct(Product product) async {
    final db = await getInstance.database;
    await db.update(
      'products',
      product.toMap(),
      where: 'productId = ?',
      whereArgs: [product.productId],
    );
  }

  static Future<void> deleteProduct(String productId) async {
    final db = await getInstance.database;
    await db.delete(
      'products',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  static Future<void> delete() async {
    final db = await getInstance.database;
    await db.delete(
      'products'
    );
  }

}

