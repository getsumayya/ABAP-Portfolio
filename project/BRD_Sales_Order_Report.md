# Business Requirement Document (BRD)  
# ビジネス要件定義書

## 1. Project Overview / プロジェクト概要
The goal of this project is to develop an ABAP report that displays Sales Orders filtered by Creation Date and Created By (User Name). The report must also include a Print Preview functionality so that users can review the formatted output before printing.

本プロジェクトの目的は、作成日および 作成者（ユーザー名） を条件として、販売伝票一覧を表示する ABAP レポートを開発することである。
さらに、ユーザーが印刷前にレイアウトを確認できる 印刷プレビュー機能 を提供する。

## 2. Objective / 目的  
To enable users to quickly search and view Sales Orders based on specific criteria.

To allow printing of the Sales Order list in a standard, readable format.

ユーザーが指定した条件で販売注文を迅速に検索・表示できるようにする。

販売伝票一覧を標準的で読みやすい形式で印刷できるようにする。

## 3. Scope / 範囲  
In Scope / 対象範囲内

Selection screen (Creation Date, Created By)

ALV output

Print preview

（対象範囲内）

選択画面（作成日、作成者）

ALV 表示

印刷プレビュー機能

## 4. Requirements / 要件  
BR-01: Creation Date Selection

User must be able to filter Sales Orders using a date range.
BR-01: 作成日選択
ユーザーは日付範囲で販売伝票を抽出できること。

BR-02: Created By Filter

User must be able to filter by User Name (ERNAM).
BR-02: 作成者フィルタ
ユーザーは作成者（ERNAM）で抽出できること。

BR-03: ALV Output

The system must display the extracted Sales Orders in an ALV list.
BR-03: ALV 出力
抽出結果は ALV 形式で表示されること。

BR-04: Print Preview

A print preview must be available before printing.
BR-04: 印刷プレビュー
印刷前にプレビューを表示できること。
