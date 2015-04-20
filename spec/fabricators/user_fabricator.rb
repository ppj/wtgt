Fabricator(:user) do
  fullname { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  hometown { Faker::Address.city }
  country { Faker::Address.country }
end
