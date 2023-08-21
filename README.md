# README

## users テーブル

|Column                          |Type   |Options   |
|--------------------------------|-------|----------|
|nickname                        |string |null:false|
|email                           |string |null:false|
|encrypted_password              |string |null:false|
|last_name(full_width)           |string |null:false|
|first_name(full_width)          |string |null:false|
|last_name(full_width_katakana)  |string |null:false|
|first_name(full_width_katakana) |string |null:false|
|birthday                        |string |null:false|

### Association
- has_many :items
- has_many :purchase_records



## items　テーブル

|Column        |Type   |Options   |
|--------------|-------|----------|
|user_id       |string |null:false|
|user_nickname |string |null:false|
|item          |string |null:false|
|explanation   |string |null:false|
|category      |string |null:false|
|status        |string |null:false|
|shipping_fee  |string |null:false|
|region_origin |string |null:false|
|price         |string |null:false|
|image         |string |null:false|

### Association
- belongs_to :users
- has_one_to :purchase_records



## purchase_records テーブル

|Column           |Type   |Options   |
|-----------------|-------|----------|
|user_id          |string |null:false|
|item_id          |string |null:false|
|shipping_area_id |string |null:false|

### Association
- belongs_to :users
- belongs_to :items
- has_one_to :shipping_areas




## shipping_areas

|Column             |Type   |Options   |
|-------------------|-------|----------|
|purchase_record_id |string |null:false|
|shipping_address   |string |null:false|


### Association
- belongs_to :purchase_records