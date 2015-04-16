Fabricator(:place) do
  name { Faker::Lorem.word }
  country { Faker::Lorem.word }
end
