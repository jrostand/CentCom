module CentCom
  DB = Sequel.postgres(
    host: CentCom::Settings.db_host,
    port: CentCom::Settings.db_port,
    user: CentCom::Settings.db_user,
    password: CentCom::Settings.db_password,
    database: CentCom::Settings.db_database
  )
end
