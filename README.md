# gacha_sample
簡易的なガチャ実装

## 概要
レコード群から指定の重みに応じて、ランダムでレコードを抽出します。

## 使い方

モデルにincludeします。
set_gacha_weight_columnに重みを格納したカラムを指定します(デフォルトはweight)

class Gacha < ActiveRecord::Base
  include GachaSample
  set_gacha_weight_column :weight_hi
end

## 例

### Gachaの全レコードから1レコードを抽出

Gacha.gacha

### Gachaを絞り込んで1レコードを抽出

Gacha.where(kind: :rare).gacha

### 複数のレコードを抽出(被り有り)

Gacha.gacha(4)

### 複数のレコードを抽出(被りなし)

Gacha.gacha(4, unique: true)

抽出元のレコード数が指定した抽出数未満の場合は、指定数よりも少ない件数が返却されます。


### デフォルトと異なる重みカラムを使って抽出

Gacha.gacha(nil, column: :weight_rare)

