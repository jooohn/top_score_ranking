# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
score_seed = [
  { player: 'bob', score: 100, time: '2021-04-01' },
  { player: 'bob', score: 140, time: '2021-04-02' },
  { player: 'bob', score: 120, time: '2021-04-03' },
  { player: 'alice', score: 200, time: '2021-04-01' },
  { player: 'alice', score: 240, time: '2021-04-02' },
  { player: 'alice', score: 220, time: '2021-04-03' },
]
Score.create!(score_seed)
