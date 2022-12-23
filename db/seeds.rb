User.delete_all
Like.delete_all
ReviewLike.delete_all
Review.delete_all
Coffee.delete_all
Origin.delete_all

origin = ['Sul de Minas', 'Mantiqueira de Minas', 'Matas de Minas',
          'Cerrado Mineiro', 'Alta Mogiana', 'Chapada Diamantina (BA)',
          'Montanhas do Espírito Santo', 'Norte Pioneiro do Paraná', 'Rondônia',
          'Ceará','Caparaó (ES)', 'Caparaó (MG)', 'Mococa (SP)']
origin.each do |orig|
  Origin.create!(name: orig)
end

User.create!(first_name: 'Rafael', about: 'Trabalho como barista minha vida é o café', password: '123123', email:'teste1@teste')
User.create!(first_name: 'Vini', about: 'Curto um café brabo, só tomo pelé', password: '123123', email:'teste2@teste')
User.create!(first_name: 'Marina', about: 'Buscando cafés produzidos por mulheres', password: '123123', email:'teste3@teste')
User.create!(first_name: 'Ana', about: 'Adoro viajar, conhecer sabores e lugares novos', password: '123123', email:'teste4@teste')
User.create!(first_name: 'Letícia', about: 'O café me ajuda a cobrir Ralis pelo mundo', password: '123123', email:'teste5@teste')
User.create!(first_name: 'Fabi', about: 'Pau no cu do Melitta, eu gosto é de café bom', password: '123123', email:'teste6@teste')

roast = ['clara', 'média', 'escura']
sensory = ['frutado', 'achocolatado', 'floral']
taste = ['doce', 'ácido', 'equilibrado', 'amargo']
name = ['Rafael','Vini','Marina', 'Ana', 'Letícia', 'Fabi']
review = ['Muito bom', 'Café sensacional', 'Não gostei, muito amargo',
          'Muito fraco', 'Este me lembrou notas de frutas vermelhas pela manhã',
         'Péssimo', 'Gostei muito', 'Este café tem notas de castanha do Pará e é encorpado']
nome_cafe = ['Melita sabor da fazenda', 'Honey da bahia', 'Santa Mônica',
             'Café do Centro', 'Spot Coffee', 'Café do Joselino', 'Café Capadocia',
             'Café do Pato Rei', 'Fuckoffee']
store = ['Coffee Lab', 'Por um Punhado de Dólares', 'Cafeteria Grão', 'Hey Coffee', 'Café da Praça',
          'Baden Torrefação', 'Soul Café', 'Cupping Café', 'Bento 43 Café']
address = ['Rua Fradique Coutinho, 1430', 'Rua Dom José de Barros, 152', 'Rua Nestor Pestana, 115',
            'Rua Augusta, 1524', 'Rua Wisard, 171', 'Rua Bento Freitas, 306',
            'Rua Júlio Conceição, 553', 'Avenida Paulista, 1001', 'Rua Oscar Freire, 2286']

b = User.find_by(first_name: name.sample)
  nome_cafe.each do |nome|
  a = Origin.find_by_name(origin.sample)
  coffee = Coffee.create!(
    name: nome,
    brand: Faker::App.name,
    sensory: sensory.sample,
    taste: taste.sample,
    origin_id: a.id,
    roast: roast.sample,
    farm: Faker::Team.name,
    store: store.sample,
    address: address.sample,
    user: b)
  5.times do
      b = User.find_by(first_name: name.sample)
    Review.create!(
      content: review.sample,
      rating: rand(1..5),
      user: b,
      coffee: coffee)
  end
end