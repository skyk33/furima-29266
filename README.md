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
| category | string | null: false |
| condition | string | null: false |
| delivery_charge_type | string | null: false |
| delivered_from | string | null: false |
| delivery_days | string | null: false |
| price | string | null: false |
| availability | boolean | null: false |

### Association

- belongs_to :user
- has_one :purchase_order
- has_one_attached :image


## purchase_orders テーブル

| Column | Type | Options |
| ------ | ---- | ------- |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
| payment_details_id | references | null: false, foreign_key: true |
| delivery_address_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :items
- has_one :payment_detail
- has_one :delivery_address

## payment_details テーブル

| Column | Type | Options |
| ------ | ---- | ------- |
| card_number | integer | null:false |
| expiry_month | integer | null: false |
| card_holders_name | string | null: false |
| security_code | integer | null: false |

### Association

- belongs_to :purchase_order

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
