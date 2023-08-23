# README

## users テーブル

| Column                          | Type   | Options    |
| ------------------------------- | ------ | ---------- |
| nickname                        | string | null:false |
| email                           | string | null:false |
| encrypted_password              | string | null:false |
| last_name_full_width            | string | null:false |
| first_name_full_width           | string | null:false |
| last_name_full_width_katakana   | string | null:false |
| first_name_full_width_katakana  | string | null:false |
| birthday                        | date   | null:false |

### Association
- has_many :items
- has_many :purchase_records



## items テーブル

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| name             | string     | null:false                    |
| explanation      | text       | null:false                    |
| category         | integer    | null:false                    |
| status           | integer    | null:false                    |
| shipping_fee     | integer    | null:false                    |
| prefectures      | integer    | null:false                    |
| preparation_days | integer    | null:false                    |
| price            | integer    | null:false                    |
| user             | references | null:false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase_record
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :shipping_fee
- belongs_to_active_hash :prefectures
- belongs_to_active_hash :preparation_days


## purchase_records テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null:false, foreign_key: true |
| item   | references | null:false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_area



## shipping_areas テーブル

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| postal_code      | string     | null:false                    |
| prefectures      | integer    | null:false                    |
| city             | string     | null:false                    |
| address          | string     | null:false                    |
| building__name   | string     | null:false                    |
| phone_number     | string     | null:false                    |
| purchase_record  | references | null:false, foreign_key: true |

### Association
- belongs_to :purchase_record
- belongs_to_active_hash :prefectures