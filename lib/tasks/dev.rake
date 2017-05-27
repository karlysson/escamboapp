
namespace :dev do


  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public','system')

    puts "###### Executando setup no desenvolvimento... ######"
    puts "Apagando o BD... #{%x(rake db:drop)}"

    if Rails.env.development?
      puts "Apagando imagens de public/system #{%x(rm -rf #{images_path})}"
    end

    puts "Criando o BD...#{%x(rake db:create)}"
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)
    puts %x(rake dev:generate_comments)

    puts "###### Setup Executado com Sucesso... ######"
  end

  ######################################################################

  desc "Cria Administradores Fake"
  task generate_admins: :environment do

    puts "###### Cadastrando os Administradores ... ######"

    10.times do
        Admin.create!(
              name: Faker::Name.name,
              email: Faker::Internet.email,
              password: "123456",
              password_confirmation: "123456",
              role: [0,0,1,1,1].sample)
    end

    puts "###### Administradores cadastrados com Sucesso... ######"
  end

  ######################################################################

 desc "Cria Membros Fake"
  task generate_members: :environment do

    puts "###### Cadastrando os Membros ... ######"

    100.times do
        member = Member.new(
              email: Faker::Internet.email,
              password: "123456",
              password_confirmation: "123456")
        member.build_profile_member
        member.profile_member.first_name = Faker::Name.first_name
        member.profile_member.second_name = Faker::Name.last_name

        member.save!
    end

    puts "###### Membros cadastrados com Sucesso... ######"
  end

  ######################################################################


  desc "Criar Anucios Fake"
  task generate_ads: :environment do

    puts " ###### Cadastrando Anúncios ######"

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_faker,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Faker::Date.forward(23),
        picture: File.new(Rails.root.join('public', 'templates',
                                'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )

    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_faker,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Faker::Date.forward(23),
        picture: File.new(Rails.root.join('public', 'templates',
                                'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
        )

    end
    puts " ###### Anúncios cadastrados com Sucesso ######"
  end

  def markdown_faker
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end



 ######################################################################

 desc "Cria Comentários Fake"
  task generate_comments: :environment do

    puts "###### Cadastrando os Comentários ... ######"

    Ad.all.each do |a|
      Random.rand(3).times do
        Comment.create!(
              body: Faker::Lorem.paragraph([1,2,3].sample),
              member: Member.all.sample,
              ad: a)
          end
      end

    puts "###### Comentários cadastrados com Sucesso... ######"
  end

  ######################################################################




end