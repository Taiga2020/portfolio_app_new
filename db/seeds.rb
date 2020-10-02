# メインのサンプルユーザーを1人作成する
User.create!(name:  "Admin User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true)

# 追加のユーザーをまとめて生成する
19.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true)
end

# メインのサンプルアニメを1つ作成
Anime.create!(title:       "NEW GAME!",
              image:       "newgame.img",
              description: "NEW GAME!の紹介文",
              furigana:    "さんがつのらいおん")

Anime.create!(title:       "遊☆戯☆王",
              image:       "yugiou.img",
              description: "遊☆戯☆王の紹介文",
              furigana:    "ゆうぎおう")

Anime.create!(title:       "とある魔術の禁書目録",
              image:       "toarumajyutsu.img",
              description: "とある魔術の禁書目録の紹介文",
              furigana:    "とあるまじゅつのいんでっくす")

Anime.create!(title:       "灼眼のシャナ",
              image:       "syakugan.img",
              description: "灼眼のシャナの紹介文",
              furigana:    "しゃくがんのしゃな")

Anime.create!(title:       "ハヤテのごとく！",
              image:       "hayate.img",
              description: "ハヤテのごとく！の紹介文",
              furigana:    "はやてのごとく！")

Anime.create!(title:       "アズールレーン",
              image:       "azurlane.img",
              description: "アズールレーンの紹介文",
              furigana:    "あずーるれーん")

Anime.create!(title:       "神のみぞ知るセカイ",
              image:       "kaminomi.img",
              description: "神のみぞ知るセカイの紹介文",
              furigana:    "かみのみぞしるせかい")

Anime.create!(title:       "ナルト疾風伝",
              image:       "naruto.img",
              description: "ナルト疾風伝の紹介文",
              furigana:    "なるとしっぷうでん")

Anime.create!(title:       "３月のライオン",
              image:       "sangatsu.img",
              description: "３月のライオンの紹介文",
              furigana:    "さんがつのらいおん")

Anime.create!(title:       "宇宙よりも遠い場所",
              image:       "yorimoi.img",
              description: "宇宙よりも遠い場所の紹介文",
              furigana:    "そらよりもとおいばしょ")

Anime.create!(title:       "魔法少女まどか☆マギカ",
              image:       "madomagi.img",
              description: "魔法少女まどか☆マギカの紹介文",
              furigana:    "まほうしょうじょまどかまぎか")

# 追加のアニメデータをまとめて作成
# 8.times do |n|
#   title  = Faker::Coffee.blend_name
#   image = "sample#{n+1}.img"
#   description = "description-#{n+1}"
#   Anime.create!(title: title,
#                image: image,
#                description: description)
# end
