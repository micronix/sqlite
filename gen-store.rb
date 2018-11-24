require 'sqlite3'
require 'faker'

db = SQLite3::Database.new "store.db"

# users table
rows = db.execute <<-SQL
  create table users(
    id integer primary key,
    first_name varchar,
    last_name varchar,
    email varchar unique,
    password varchar,
    address varchar,
    city varchar,
    state varchar,
    zip varchar
  );
SQL

100.times do
  values = [
    Faker::Name.first_name,
    Faker::Name.last_name,
    Faker::Internet.unique.email,
    Faker::Internet.password,
    Faker::Address.street_address,
    Faker::Address.city,
    Faker::Address.state_abbr,
    Faker::Address.zip
  ]
db.execute "
  insert into users(first_name, last_name, email, password, address, city, state, zip)
  values(?, ?, ?, ?, ?, ?, ?, ?)", values
end

# books
rows = db.execute <<-SQL
  create table books(
    id integer primary key,
    title varchar,
    genre varchar,
    author varchar,
    isbn varchar,
    image varchar,
    price numeric
  );
SQL

100.times do
  values = [
    Faker::Book.unique.title,
    Faker::Book.genre,
    Faker::Book.author,
    Faker::Code.isbn,
    Faker::LoremFlickr.image("300x300", ['nature']) + "?r=#{rand(100)}",
    Faker::Commerce.price,
  ]
  db.execute "insert into books(title, genre, author, isbn, image, price)
  values(?, ?, ?, ?, ?, ?)", values
end

# orders
rows = db.execute <<-SQL
  create table orders(
    id integer primary key,
    purchased date,
    user_id integer,
    book_id integer,
    quantity integer
  )
SQL
