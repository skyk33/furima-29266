FactoryBot.define do
  factory :user do
    nickname {"nickname"}
    email {"test@example.com"}
    password = "test01"
    password {password}
    password_confirmation {password}
    family_name {"米田"}
    first_name {"こめ"}
    family_name_kana {"コメダ"}
    first_name_kana {"コメ"}
    birthday {"2000-01-11"}
  end
end
