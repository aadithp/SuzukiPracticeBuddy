import 'package:SuzukiPracticeBuddy/pages/achievements/achievement.dart';
import 'package:SuzukiPracticeBuddy/pages/shop/inventory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../screens/review/Piece.dart';
import '../pages/shop/shopItem.dart';

//review pieces table properties
final String reviewPiecesTable = 'reviewPieces';
final String reviewPiecesIdColumn = 'id';
final String nameColumn = 'name';

//badge history table properties
final String badgeHistoryTable = 'badgeHistory';
final String dayColumn = 'day';
final String taskCounterColumn = 'taskCounter';
final String doneStatusColumn = 'doneStatus';

//current piece table properties
final String currentPieceTable = 'currentPiece';
final String currentPieceIdColumn = 'id';

//currency table properties
final String currencyTable = 'currency';
final String valueColumn = 'value';

//shop table properties
final String shopTable = 'shop';
final String imageNameColumn = 'imageName';
final String itemNameColumn = 'itemName';
final String itemPriceColumn = 'itemPrice';
final String itemOwnedColumn = 'itemOwned';

//background table properties
final String backgroundTable = 'background';
final String backgroundImageNameColumn = 'backgroundImageName';

//achievements data table
final String achievementsTable = 'achievements';
final String achievementNameColumn = 'achievementName';
final String achievementCompleteStatusColumn = 'achievementCompleteStatus';
final String achievementDescriptionColumn = 'achievementDescription';
final String achievementImageColumn = 'achievementImage';

//total coin earned ever, for tracking achievements
final String totalCoinsTable = 'totalCoins';
final String totalColumn = 'total';

//Access table
final String accessTable = 'access';
final String firstAccess = 'firstAccess';

//maps id value from database to an int
convertId(Map<String, dynamic> map) {
  int id = map['id'];
  return id;
}

//maps currency value from database to an int
mapValue(Map<String, dynamic> map) {
  int value = map['value'];
  return value;
}

//maps text from database to a string
mapString(Map<String, dynamic> map) {
  String string = map['backgroundImageName'];
  return string;
}

//database provider class
class GeneralDBProvider {
  static final _databaseName = "generalDatabase.db";
  static final _databaseVersion = 10;

  GeneralDBProvider._privateConstructor();

  static final GeneralDBProvider instance =
      GeneralDBProvider._privateConstructor();

  //the database
  static Database _database;

  //gets the database if it exists, otherwise creates a new one
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  //Initialises database
  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // print('Updated');
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE reviewPieces');
      await db.execute('DROP TABLE badgeHistory');
      await db.execute('DROP TABLE currentPiece');
      await db.execute('DROP TABLE currency');
      await db.execute('DROP TABLE shop');
      await db.execute('DROP TABLE background');
      await db.execute('DROP TABLE achievements');
      await db.execute('DROP TABLE totalCoins');
      await db.execute('DROP TABLE access');
      await _onCreate(db, newVersion);
    }
  }

  //creates the tables in the database and populates them the first time the app is used on a device
  Future _onCreate(Database db, int version) async {
    //creating database tables
    // print('created');
    await db.execute('''
              CREATE TABLE $reviewPiecesTable (
                $reviewPiecesIdColumn INTEGER PRIMARY KEY,
                $nameColumn TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $badgeHistoryTable (
                $dayColumn TEXT PRIMARY KEY,
                $taskCounterColumn INTEGER,
                $doneStatusColumn TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $currentPieceTable (
                $currentPieceIdColumn INTEGER PRIMARY KEY
              )
              ''');
    await db.execute('''
              CREATE TABLE $currencyTable (
                $valueColumn INTEGER PRIMARY KEY
              )
              ''');
    await db.execute('''
              CREATE TABLE $shopTable (
                $imageNameColumn TEXT,
                $itemNameColumn TEXT,
                $itemPriceColumn INTEGER,
                $itemOwnedColumn TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $backgroundTable (
                $backgroundImageNameColumn TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $achievementsTable (
                $achievementNameColumn TEXT,
                $achievementCompleteStatusColumn TEXT,
                $achievementDescriptionColumn TEXT,
                $achievementImageColumn Text
              )
              ''');
    await db.execute('''
              CREATE TABLE $totalCoinsTable (
                $totalColumn INT
              )
              ''');
    await db.execute('''
              CREATE TABLE $accessTable (
                $firstAccess TEXT
              )
              ''');

    //initial currentPieceNumber
    await db.rawInsert('''
      INSERT INTO currentPiece(
        id
      ) VALUES (?)
    ''', [100]);

    //initial backgroundImage
    await db.rawInsert('''
      INSERT INTO background(
        backgroundImageName
      ) VALUES (?)
    ''', ['launch_icon-playstore.png']);

    //initial badge progress status
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Mon', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Tue', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Wed', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Thu', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Fri', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Sat', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Sun', 0, 'false,false,false']);

    //shop items
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['piano_heart.jpg', 'Piano heart background', 500, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['pink_music_notes.jpg', 'Pink musical background', 800, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['purple_frame.jpg', 'Purple frame background', 1000, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['gold_frame.jpg', 'Golden frame background', 1000, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['gold_frame_black.jpg', 'Dark frame background', 1200, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['blue_crystal.jpg', 'Sky crystal background', 1200, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['red_music_notes.jpg', 'Musical sunset background', 1200, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['midnight_blue.jpg', 'Midnight blue background', 1200, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['water_colour_space.jpg', 'Night clouds background', 1500, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''',
        ['yellow_explosion.jpg', 'Yellow explosion background', 1500, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['colourful_nature.jpg', 'Natural colour background', 1500, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['floral.jpg', 'Floral white background', 1800, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['clouds.jpg', 'Cartoon clouds background', 2000, 'false']);
    await db.rawInsert('''
      INSERT INTO shop(
        imageName, itemName, itemPrice, itemOwned
      ) VALUES (?, ?, ?, ?)
    ''', ['astronaut.jpg', 'Spacedude background', 3000, 'false']);

    //users starting money
    await db.rawInsert('''
      INSERT INTO currency(
        value
      ) VALUES (?)
    ''', [0]);

    //achievements
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Using your ears', 'false', 'Completed your first listening task', 'listeningAchievement.jpg']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Practice makes perfect', 'false', 'Completed your first review task', 'reviewAchievement.jpg']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Coin collector', 'false', 'Earned 500 total coins', 'dollarEdit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['New shopper', 'false', 'Bought your first item', 'shoppingAchievement.jpg']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Go for gold!', 'false', 'Earned your first gold badge', 'gold_badge_3Edit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['More coins', 'false', 'Earned 1000 total coins', 'dollarEdit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Item collector', 'false', 'Own 5 items', 'itemCollector.jpg']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Coin expert', 'false', 'Earned 2500 total coins', 'dollarEdit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Coin master', 'false', 'Earned 5000 total coins', 'dollarEdit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Quite a collection', 'false', 'Own 10 items', 'itemCollector.jpg']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Filling the bank', 'false', 'Earned 10000 total coins', 'dollarEdit.png']);
    await db.rawInsert('''
      INSERT INTO achievements(
        achievementName, achievementCompleteStatus, achievementDescription, achievementImage
      ) VALUES (?, ?, ?, ?)
    ''', ['Completionist', 'false', 'Completed all achievements', 'completionistEdit.png']);

    //total coins history
    await db.rawInsert('''
      INSERT INTO totalCoins(
        total
      ) VALUES (?)
    ''', [0]);

    //Access history
    await db.rawInsert('''
      INSERT INTO access (
        firstAccess
      ) VALUES (?)
    ''', ['true']);
  }

  //returns the current piece id from the database
  getCurrentPieceId() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM currentPiece');
    int id = convertId(res[0]);
    return id;
  }

  //updates the current piece id to a given value
  updateCurrentPieceId(int id) async {
    Database db = await database;
    var res = await db.rawDelete('DELETE FROM currentPiece');
    res = await db.rawInsert('''
      INSERT INTO currentPiece(
        id
      ) VALUES (?)
    ''', [id]);
    return res;
  }

  //Queries the badgeHistory table for record of given day
  getBadgeHistory(String day) async {
    Database db = await database;
    var res = await db
        .rawQuery('SELECT * FROM badgeHistory WHERE day = ? LIMIT 1', [day]);
    return res;
  }

  //Updates record of given day
  updateBadgeHistory(String day, int taskCounter, List<bool> doneStatus) async {
    Database db = await database;
    String doneStatusString = doneStatus[0].toString() +
        "," +
        doneStatus[1].toString() +
        "," +
        doneStatus[2].toString();
    var res = await db.rawQuery(
        'UPDATE badgeHistory SET taskCounter = ?, doneStatus = ? WHERE  day = ?',
        [taskCounter, doneStatusString, day]);
    return res;
  }

  //Adds piece to the reviewPieces table
  addToReviewList(Piece piece) async {
    Database db = await database;
    var res = await db.rawInsert('''
      INSERT INTO reviewPieces(
        id, name
      ) VALUES (?, ?)
    ''', [piece.id, piece.name]);
    return res;
  }

  //Removes piece from the reviewPieces table
  removeFromReviewList(Piece piece) async {
    int pieceId = piece.id;
    Database db = await database;
    var res =
        await db.rawDelete('DELETE FROM reviewPieces WHERE id = ?', [pieceId]);
    return res;
  }

  //Queries the reviewPieces table for all review pieces
  Future<dynamic> getReviewList() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM reviewPieces');
    return res;
  }

  //Clears the reviewPieces table
  emptyReviewList() async {
    Database db = await database;
    await db.rawDelete('DELETE FROM reviewPieces');
  }

  //gets the current amount of 'money' the user has available
  getCurrencyValue() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM currency');
    int value = mapValue(res[0]);
    return value;
  }

  //updates the users 'money' to a given value
  updateCurrencyValue(int value) async {
    Database db = await database;
    await db.rawDelete('DELETE FROM currency');
    await db.rawInsert('''
      INSERT INTO currency(
        value
      ) VALUES (?)
    ''', [value]);
  }

  //resets all piece progression and badge progress to the default start-up values
  resetAllProgress() async {
    Database db = await database;
    await updateCurrentPieceId(100);
    await emptyReviewList();
    await db.rawDelete('DELETE FROM badgeHistory');
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Mon', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Tue', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Wed', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Thu', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Fri', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Sat', 0, 'false,false,false']);
    await db.rawInsert('''
      INSERT INTO badgeHistory(
        day, taskCounter, doneStatus
      ) VALUES (?, ?, ?)
    ''', ['Sun', 0, 'false,false,false']);
    await updateCurrencyValue(0);
    await clearInventory();
    await changeBackground('launch_icon-playstore.png');
    await resetAchievements();
    await resetTotalCoins();
    return null;
  }

  //returns a list of items that are in the shop
  getShopItems() async {
    Database db = await database;
    List<Map<String, dynamic>> res = await db.rawQuery('SELECT * FROM shop');
    List<ShopItem> shopItems = [];
    for (int x = 0; x < res.length; x++) {
      shopItems.add(ShopItem.convertToItem(res[x]));
    }
    return shopItems;
  }

  //'purchase' an item from the shop, updating its owned status to true if
  // the user can afford the item
  buyItem(ShopItem item) async {
    Database db = await database;
    int currentMoney = await getCurrencyValue();
    //check the user has sufficient funds to purchase item
    if (currentMoney < item.itemPrice) {
      return false;
    }
    await updateCurrencyValue(currentMoney - item.itemPrice);
    await db.rawQuery('UPDATE shop SET itemOwned = ? WHERE itemName = ?',
        ['true', item.itemName]);
    return true;
  }

  awardCoins(int value) async {
    int currentValue = await getCurrencyValue();
    await updateCurrencyValue(currentValue + value);
    await updateTotalCoins(value);
  }

  //returns a list of items the user currently owns
  getInventory() async {
    return Inventory.convertToInventory(
        await getInventoryImageNames(), await getInventoryItemNames());
  }

  //gets the image names for items the user owns
  getInventoryImageNames() async {
    Database db = await database;
    var imageNames = await db
        .rawQuery('SELECT imageName FROM shop WHERE itemOwned = ?', ['true']);
    return imageNames;
  }

  //gets the item names for items the user owns
  getInventoryItemNames() async {
    Database db = await database;
    var itemNames = await db
        .rawQuery('SELECT itemName FROM shop WHERE itemOwned = ?', ['true']);
    return itemNames;
  }

  //clears the users inventory and makes the items available in the shop again
  clearInventory() async {
    Database db = await database;
    await db.rawQuery(
        'UPDATE shop SET itemOwned = ? WHERE itemOwned = ?', ['false', 'true']);
  }

  //updates background image name
  changeBackground(String newBackground) async {
    Database db = await database;
    await db.rawDelete('DELETE from background');
    await db.rawInsert('''
      INSERT INTO background(
        backgroundImageName
      ) VALUES (?)
    ''', [newBackground]);
  }

  // gets the current background image file name
  getBackground() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT backgroundImageName FROM background');
    String background = mapString(res[0]);
    return background;
  }

  //sets an achievement to completed. Returns true if first time getting achievement
  completeAchievement(String achievementName) async {
    Database db = await database;
    var res = await db.rawQuery(
        'SELECT achievementCompleteStatus FROM achievements WHERE achievementName = ?',
        [achievementName]);
    String status = res[0]['achievementCompleteStatus'];
    if (status == 'false') {
      await db.rawUpdate(
          'UPDATE achievements SET achievementCompleteStatus = ? WHERE achievementName = ?',
          ['true', achievementName]);
      return true;
    } else {
      return false;
    }
  }

  getAchievement(String name) async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM achievements WHERE achievementName = ?', [name]);
    Achievement achievement = Achievement.mapAchievement(res[0]);
    return achievement;
  }

  mapAllAchievements(List<Map<String, dynamic>> map) {
    List<Achievement> achievementsList = [];
    for (int x = 0; x < map.length; x++) {
      String name = map[x]['achievementName'];
      bool completeStatus;
      if (map[x]['achievementCompleteStatus'] == 'true') {
        completeStatus = true;
      } else {
        completeStatus = false;
      }
      String description = map[x]['achievementDescription'];
      String image = map[x]['achievementImage'];
      Achievement achievement = Achievement(name, completeStatus, description, image);
      achievementsList.add(achievement);
    }
    return achievementsList;
  }

  getAllAchievements() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM achievements');
    List<Achievement> achievements = mapAllAchievements(res);
    return achievements;
  }

  //resets all achievements
  resetAchievements() async {
    Database db = await database;
    await db.rawUpdate('UPDATE achievements SET achievementCompleteStatus = ?', ['false']);
  }

  //gets total coins earned ever count
  getTotalCoins() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT total FROM totalCoins');
    int value = res[0]['total'];
    return value;
  }

  //updates total coins history
  updateTotalCoins(int value) async {
    Database db = await database;
    int currentValue = await getTotalCoins();
    int newValue = currentValue + value;
    await db.rawUpdate('UPDATE totalCoins SET total = ?', [newValue]);
  }

  //resets the total coins earned count to 0
  resetTotalCoins() async {
    Database db = await database;
    await db.rawUpdate('UPDATE totalCoins SET total = ?', [0]);
  }

  getAccess() async {
    Database db = await database;
    var res = await db.rawQuery('SELECT * FROM access');
    return res;
  }

  //Sets first access to false
  updateAccess() async {
    Database db = await database;
    await db.rawUpdate(
        'UPDATE access SET firstAccess = ?',
        ['false']);
  }
}
