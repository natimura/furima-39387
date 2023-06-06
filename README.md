# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birth_year         | integer | null: false               |
| birth_month        | integer | null: false               |
| birth_day          | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type    | Options                        |
| ----------       | ------- | ------------------------------ |
| user_id          | integer | null: false, foreign_key: true |
| name             | string  | null: false                    |
| explanation      | text    | null: false                    |
| category         | string  | null: false                    |
| condition        | string  | null: false                    |
| delivery_load    | string  | null: false                    |
| delivery_address | string  | null: false                    |
| delivery_days    | string  | null: false                    |
| price            | integer | null: false                    |

### Association

- belongs_to :user

## orders テーブル

| Column  | Type    | Options                        |
| --------| --------| ------------------------------ |
| user_id | integer | null: false, foreign_key: true |
| item_id | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## shippings テーブル

| Column         | Type    | Options                        |
| ---------      | --------| ------------------------------ |
| order_id       | integer | null: false, foreign_key: true |
| post_code      | integer | null: false                    |
| prefectures    | string  | null: false                    |
| municipalities | string  | null: false                    |
| address        | string  | null: false                    |
| building       | string  |                                |
| phone_num      | integer | null: false                    |


### Association

- belongs_to :order
