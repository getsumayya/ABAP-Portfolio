# Technical Specification
# 詳細設計書


## 1. Technical Overview / 技術概要
| 項目 (Item)                          | 内容 (Description)                                                                                                 |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| **Title / タイトル**                 | Sales Order Interactive ALV Report                                                                                   |
| **Description / 説明**               | A custom ABAP report that displays Sales Order item details using an interactive ALV Grid with SmartForm output.     |
| **Object Type / オブジェクト種別**   | Report Program                                                                                                       |
| **Object Name / プログラム名**        | ZPRG_SALES_REPORT                                                                                                    |
| **Package Name / パッケージ名**       | ZPKG_SALESORD                                                                                                     |
| **Transaction Code / トランザクションコード** | ZTC_SALES                                                                                                         |
| **Type of Requirement / 要件種別**   | New Development                                                                                                      |
| **Development Priority / 開発優先度** | Medium                                                                                                               |
| **Functional Consultant / 機能担当** | \<->                                                                                     |
| **Developer / 開発担当**             | \SUMAYYA NAZEER SHAHIDA                                                                                                         |


## 2.Data Model / データモデル
Tables Used / 使用テーブル

VBAK – Sales Order Header

VBAP – Sales Order Item

MAKT – Material Description

Required Fields / 必須フィールド

VBELN, POSNR, MATNR, MAKTX, KWMENG, VRKME

5.3 Internal Tables & Structures / 内部テーブル・構造体

ZTT_SO_OUTPUT (joined output)



## 3.Processing Logic / 処理ロジック


Fetch Sales Orders from VBAK
Retrieve sales document numbers (VBELN) from table VBAK based on creation date (ERDAT) and created-by user (ERNAM).

Fetch Item Details from VBAP
Using the VBELN list from Step 1, fetch the following fields from VBAP:
VBELN, POSNR, MATNR, KWMENG, VRKME.

Fetch Material Descriptions from MAKT
Retrieve material description (MAKTX) from table MAKT by passing the material numbers (MATNR) obtained in Step 2.

Display Output Using ALV Grid
Display the processed data in an ALV Grid using Function Module:
REUSE_ALV_GRID_DISPLAY.

Create One Custom ALV Toolbar Button (PF-STATUS)
Add one custom button to the ALV application toolbar using PF-STATUS.

This button triggers SmartForm output, passing the selected report data to the SmartForm.

SmartForm Output
Create a SmartForm and pass the internal table data to generate formatted output.

Message Class - ZMSG_SALES
Create a message class to provide system and user messages for the report.


VBAK から受注データ取得
作成日 (ERDAT) と 作成者 (ERNAM) を条件に、VBAK テーブルから受注番号 (VBELN) を取得する。

VBAP から明細データ取得
ステップ1で取得した VBELN を基に、VBAP テーブルから
VBELN、POSNR、MATNR、KWMENG、VRKME を取得する。

MAKT から品目テキスト取得
ステップ2で取得した品目番号 (MATNR) を使用し、MAKT テーブルから品目説明 (MAKTX) を取得する。

ALV 形式での一覧表示
Function Module REUSE_ALV_GRID_DISPLAY を使用して、取得したデータを ALV Grid で表示する。

ALV ツールバーにボタン追加 (PF-STATUS)
PF-STATUS を使用して、ALV アプリケーションツールバーに 1つのカスタムボタン を追加する。

このボタンを押下すると SmartForm 出力が実行され、レポートデータが SmartForm に渡される。

SmartForm 出力処理
SmartForm を作成し、内部テーブルのデータを SmartForm に渡して帳票を生成する。

メッセージクラス作成 - ZMSG_SALES
レポート用のシステムメッセージおよびユーザーメッセージを提供するため、メッセージクラスを作成する。
