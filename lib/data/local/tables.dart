import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get avatarPath => text().nullable()();
  TextColumn get carNumber => text().nullable()();
  TextColumn get carType => text().nullable()();
  TextColumn get fuelType => text().nullable()();
  RealColumn get fuelEfficiency => real().withDefault(const Constant(11.5))();
  RealColumn get fuelPrice => real().withDefault(const Constant(2.0))();
  TextColumn get currency => text().withDefault(const Constant('QAR'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkSessions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  RealColumn get rawDistanceMeters => real().withDefault(const Constant(0))();
  RealColumn get manualDistanceMeters => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get orderNumber => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  RealColumn get durationSeconds => real().withDefault(const Constant(0))();
  RealColumn get rawDistanceMeters => real().withDefault(const Constant(0))();
  RealColumn get earnings => real().withDefault(const Constant(11.5))();
  RealColumn get bonus => real().withDefault(const Constant(0))();
  RealColumn get tip => real().withDefault(const Constant(0))();
  RealColumn get fuelLiters => real().withDefault(const Constant(0))();
  RealColumn get fuelCost => real().withDefault(const Constant(0))();
  RealColumn get netIncome => real().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().nullable()();
  TextColumn get category => text()();
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class GpsPoints extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text()();
  TextColumn get orderId => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracy => real()();
  RealColumn get speed => real().withDefault(const Constant(0))();
  RealColumn get bearing => real().withDefault(const Constant(0))();
  DateTimeColumn get timestamp => dateTime()();
  BoolColumn get isAccepted => boolean().withDefault(const Constant(false))();
  TextColumn get rejectionReason => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
