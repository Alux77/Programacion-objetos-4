
require 'faker'
require 'time'
require 'csv'

=begin
* Crear la clase Person con los siguientes atributos: first_name, last_name, email, phone, created_at
* Crear un método que reciba como argumento el número de personas que quieres crear. Y regrese las personas en un arreglo.
* Faker es una librería de Ruby que nos permite generar información falsa para poder simular el comportamiento del programa con datos.
=end

class Person
  attr_accessor :first_name, :last_name, :email, :phone, :created_at

  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name  = last_name
    @email      = email
    @phone      = phone
    @created_at = created_at
  end

  def self.create_people(num_people)

    @array_people = []
    @num_people = num_people

    @num_people.times do 
      @array_people << Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, created_at = Time.now)
    end
    @array_people
  end

end

class PersonWriter
  attr_accessor :file

  def initialize(file, array)
    @file = file
    @people = array
  end

  def create_csv
    CSV.open(@file, "wb") do |csv|
      @people.each do |person|
        csv << [person.first_name , person.last_name, person.email, person.phone, person.created_at]
      end
    end
  end
end

class PersonParser
  attr_accessor :array_persons

  def initialize(file)
    @file = file
  end

  def people
     @array_persons = []
    csv_array_persons = CSV.read(@file)
    csv_array_persons.each do |row|
       @array_persons << Person.new(row[0], row[1], row[2], row[3], row[4])
    end
    p @array_persons[0..9]
  end

end

class Modified

  def initialize(file)
    @file = file
  end

  def people
    @array_persons = []
    csv_array_persons = CSV.read(@file)
    csv_array_persons.each do |row|
       @array_persons << Person.new(row[0], row[1], row[2], row[3], row[4])
    end
    @array_persons
  end

  def insert_name
    puts "insert name for search in database"
    @name_for_search = gets.chomp
    search_name
  end

  def search_name
    people
    @array_persons.each do |person|
      if @name_for_search == person.first_name
        person.email = Faker::Internet.email
      end
    end
    @array_persons
    create_csv
  end

  def create_csv
    CSV.open(@file, "wb") do |csv|
      @array_persons.each do |person|
        csv << [person.first_name, person.last_name, person.email, person.phone, person.created_at]
      end
    end
  end
end

people = Modified.new('people.csv')

people.insert_name