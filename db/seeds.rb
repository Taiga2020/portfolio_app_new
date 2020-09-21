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
Anime.create!(title:       "アズールレーン",
              image:       "azurlane.img",
              description: "アズールレーンの説明",
              furigana:    "あずーるれーん")

Anime.create!(title:       "神のみぞ知るセカイ",
              image:       "kaminomi.img",
              description: "神のみぞ知るセカイの説明",
              furigana:    "かみのみぞしるせかい")

Anime.create!(title:       "ナルト疾風伝",
              image:       "naruto.img",
              description: "ナルト疾風伝の説明",
              furigana:    "なるとしっぷうでん")

# 追加のアニメデータをまとめて作成
8.times do |n|
  title  = Faker::Coffee.blend_name
  image = "sample#{n+1}.img"
  description = "description-#{n+1}"
  Anime.create!(title: title,
               image: image,
               description: description)
end
