abstract class BaseDataSourceFactory<Type>{
  static const LOCAL = "local";
  static const REMOTE = "remote";
  Type createData(String source);
}