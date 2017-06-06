# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Populando banco de dados na tabela Category
puts "Cadastrando as Categorias ..."

categories = ["Animais e Acessórios",
              "Esportes",
              "Para a sua casa",
              "Eletrônicos e celulares",
              "Música e hobbies",
              "Bebês e crianças",
              "Moda e beleza",
              "Veículos e barcos",
              "Imóveis",
              "Empregos e negócios",
              "Cursos e Treinamentos"]

categories.each do |c|
  Category.friendly.find_or_create_by!(description: c)
end


puts "Categorias cadastradas com Sucesso..."


#Populando banco de dados na admin
puts "Cadastrando o Administrador Padrão ..."

adm = Admin.create!(
              name: "Administrador Geral",
              email: "admin@admin.com",
              password: "123456",
              password_confirmation: "123456" #,role:0
              )

adm.add_role(Role.availables[0])
adm.add_role(Role.availables[1])

puts "Administrador cadastrado com Sucesso..."

#Populando banco de dados na tabela membro
puts "Cadastrando o Membro Padrão ..."

member = Member.new(
              email: "membro@membro.com",
              password: "123456",
              password_confirmation: "123456")

member.build_profile_member
member.profile_member.first_name = Faker::Name.first_name
member.profile_member.second_name = Faker::Name.last_name

member.save!

puts "Membro Padrão cadastrado com Sucesso..."
