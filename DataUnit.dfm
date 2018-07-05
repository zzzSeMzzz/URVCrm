object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 363
  Width = 406
  object cn: TMyConnection
    Database = 'clientscrm'
    Options.Charset = 'cp1251'
    Username = 'root'
    Server = 'localhost'
    LoginPrompt = False
    Left = 8
    EncryptedPassword = '8DFF90FF90FF8BFF'
  end
  object usersQ: TMyQuery
    Connection = cn
    SQL.Strings = (
      'select users.*, '
      'department.`name` as `dname`'
      ', user_roles.`name` as `role`'
      'from users '
      'LEFT JOIN department ON (department.`id`=users.`id_dep`)'
      'LEFT JOIN user_roles ON (user_roles.`id`=users.`id_role`)'
      'GROUP BY users.id')
    Left = 8
    Top = 48
  end
  object usersDS: TDataSource
    DataSet = usersQ
    Left = 88
    Top = 48
  end
  object departmentsQ: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO department'
      '  (id, name)'
      'VALUES'
      '  (:id, :name)')
    SQLDelete.Strings = (
      'DELETE FROM department'
      'WHERE'
      '  id = :Old_id')
    SQLUpdate.Strings = (
      'UPDATE department'
      'SET'
      '  id = :id, name = :name'
      'WHERE'
      '  id = :Old_id')
    SQLRefresh.Strings = (
      'SELECT id, name FROM department'
      'WHERE'
      '  id = :id')
    SQLLock.Strings = (
      'SELECT * FROM department'
      'WHERE'
      '  id = :Old_id'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM department')
    Connection = cn
    SQL.Strings = (
      'select * from department order by name asc')
    Left = 16
    Top = 104
  end
  object handbookDS: TDataSource
    Left = 232
    Top = 104
  end
  object clientsQ: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO clients'
      '  (id, name)'
      'VALUES'
      '  (:id, :name)')
    SQLDelete.Strings = (
      'DELETE FROM clients'
      'WHERE'
      '  id = :Old_id')
    SQLUpdate.Strings = (
      'UPDATE clients'
      'SET'
      '  id = :id, name = :name'
      'WHERE'
      '  id = :Old_id')
    SQLRefresh.Strings = (
      'SELECT id, name FROM clients'
      'WHERE'
      '  id = :id')
    SQLLock.Strings = (
      'SELECT * FROM clients'
      'WHERE'
      '  id = :Old_id'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM clients')
    Connection = cn
    SQL.Strings = (
      'select * from clients order by name asc')
    Left = 88
    Top = 104
  end
  object worksQ: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO works'
      '  (id, name)'
      'VALUES'
      '  (:id, :name)')
    SQLDelete.Strings = (
      'DELETE FROM works'
      'WHERE'
      '  id = :Old_id')
    SQLUpdate.Strings = (
      'UPDATE works'
      'SET'
      '  id = :id, name = :name'
      'WHERE'
      '  id = :Old_id')
    SQLRefresh.Strings = (
      'SELECT id, name FROM works'
      'WHERE'
      '  id = :id')
    SQLLock.Strings = (
      'SELECT * FROM works'
      'WHERE'
      '  id = :Old_id'
      'FOR UPDATE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM works')
    Connection = cn
    SQL.Strings = (
      'select * from works order by name asc')
    Left = 152
    Top = 104
  end
  object taskQ: TMyQuery
    Connection = cn
    SQL.Strings = (
      'select tasks.*, '
      'clients.`name` as `client`,'
      'works.`name` as `work`,'
      'users.`user_name` as `fio`,'
      'department.`name` as `dep`'
      'from tasks '
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'
      'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'
      'LEFT JOIN users ON (users.`id`=tasks.`user_id`)'
      'LEFT JOIN department ON (department.`id`=users.`id_dep`)'
      'GROUP BY tasks.id')
    Left = 8
    Top = 176
  end
  object taskDS: TDataSource
    DataSet = taskQ
    Left = 56
    Top = 176
  end
  object tasksFilter: TMyQuery
    Connection = cn
    Left = 112
    Top = 176
  end
  object taskFDS: TDataSource
    DataSet = tasksFilter
    Left = 168
    Top = 176
  end
end
