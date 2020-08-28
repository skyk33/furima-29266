# README

# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email    | string | null: false |
| password | string | null: false |
| family_name | string | null: false |
| first_name | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |

### Association

- has_many :items
- has_many :purchase_orders

## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name | string | null: false |
| user_id | string | null: false, foreign_key: true |
| description | text | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| delivery_charge_type_id | integer | null: false |
| delivery_from_id | integer | null: false |
| delivery_days_id | integer | null: false |
| price | integer | null: false |
| availability | boolean | null: false |

### Association

- belongs_to :user
- has_one :purchase_order
- has_one_attached :image
- belongs_to_active_hash :category, :condition, delivery_charge_type, :delivery_from, :delivery_days

### ActiveHash利用するもの
- category
- condition
- delivery_charge_type
- delivery_from
- delivery_days


## purchase_orders テーブル

| Column | Type | Options |
| ------ | ---- | ------- |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :items
- has_one :delivery_address

## delivery_address テーブル

| Column | Type | Options |
| ------ | ---- | ------- |
| post_code | string | null: false |
| prefecture | string | null: false |
| city_town | string | null: false |
| street_number | string | null: false |
| building_name | string | |
| phone_number | integer | null: false |

### Association

- belongs_to :purchase_order
