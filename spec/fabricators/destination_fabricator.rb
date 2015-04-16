Fabricator(:destination) do
  category { Faker::Lorem.word }
  visited { [true, false].sample }
  place
end
