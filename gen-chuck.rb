require 'sqlite3'
require 'faker'

db = SQLite3::Database.new "chuck.db"


rows = db.execute <<-SQL
  create table facts(
    id integer primary key,
    body text,
    favorite boolean default false
  );
SQL

40.times do
  db.execute "insert into facts(body) values(?)", Faker::ChuckNorris.fact
end
