# Functional Specification – Sales Order Report
# 基本設計書


## Project Overview / プロジェクト概要

This project involves developing an ALV Interactive Grid Report for Sales Orders, including SmartForm/Adobe Form output and custom Application Toolbar buttons. The report will extract data based on Sales Order Creation Date and Created By fields.

本プロジェクトでは、販売伝票を対象とした ALV インタラクティブグリッドレポートを作成する。レポートは、作成日および作成者を条件にデータを抽出し、SmartForm フォーム出力やアプリケーションツールバーのカスタムボタンも実装する。

## Functional Requirements / 機能要件

1. Selection Screen / 選択画面

Fields:

SO Creation Date (VBAK-ERDAT)

SO Created By (VBAK-ERNAM)

Rules:

Use SELECT-OPTIONS (PARAMETERS 不使用)

If no data found → show message → Return to selection screen

選択画面では作成日と作成者を入力可能とし、該当データがない場合はメッセージ表示後、選択画面へ戻る。

2. ALV Output / ALV 表示

Requirements:

Use REUSE_ALV_GRID_DISPLAY

Manual field catalog

Interactive ALV


The ALV report must display a page header using the event TOP OF PAGE.
Inside the TOP-OF-PAGE subroutine, the system must call the function module REUSE_ALV_COMMENTARY_WRITE to render the header text.

Header Contents:

"SO Item Details"

Creation Date: <ERDAT>

Created By: <ERNAM>

"This is an ALV Interactive Report"

(Values for ERDAT and ERNAM should reflect current selection criteria.)



ALV のページヘッダーは TOP OF PAGE イベントを使用して表示する。
TOP-OF-PAGE サブルーチン内で、FM REUSE_ALV_COMMENTARY_WRITE を呼び出し、以下の内容をヘッダーに表示する。

ヘッダー内容：

"SO Item Details"（受注品目詳細）

作成日（選択画面の ERDAT）

作成者（選択画面の ERNAM）

"This is an ALV Interactive Report"（ALV インタラクティブレポート）

Display/表示:

SO Number 販売伝票番号 (VBAK-VBELN)  

Item Number 明細番号 (VBAP-POSNR)

Material Number 品目コード (VBAP-MATNR)

Material Description 品目テキスト(MAKT-MAKTX)

Quantity  受注数量(VBAP-KWMENG)

UnitofMeasurement 販売単位 (VBAP-VRKME)


3. Application Toolbar (PF-STATUS) / アプリケーションツールバー

Buttons:

Ascending Button → SmartForm Output

Shortcut: Shift + F1

Back Button → Return to selection screen

PF-STATUS にて、SmartForm 出力用ボタン（Shift+F1）および戻るボタン(BACK)を有効化する。


4. SmartForm / フォーム出力

Trigger Conditions:

When the user presses the Ascending custom button.

When the user presses the shortcut key Shift + F1.
トリガー条件

昇順ボタン押下時

Shift + F1 ショートカット押下時

Output Requirements /出力要件:

The system must call a SmartForm  to display the result.
SmartFormを呼び出し、表示する。

The form must include:

Header Section/ ヘッダー

The header must contain the following information:

"SO Item Details"

Creation Date: (same value entered on the selection screen, ERDAT)

Created By: (same value entered on the selection screen, ERNAM)
"SO Item Details"（受注品目詳細）

作成日：（選択画面で入力された ERDAT）

作成者：（選択画面で入力された ERNAM）

Item Table Section

The main table must include the following fields:

SO Number 販売伝票番号 (VBAK-VBELN)  

Item Number 明細番号 (VBAP-POSNR)

Material Number 品目コード (VBAP-MATNR)

Material Description 品目テキスト(MAKT-MAKTX)

Quantity  受注数量(VBAP-KWMENG)

UnitofMeasurement 販売単位 (VBAP-VRKME)

5. Message Handling / メッセージ要件

When No Data is Found:

Display message: "No data found for given selection."

After the user presses Enter / Continue, return automatically to the selection screen.

該当データがない場合、メッセージを表示し、ユーザが Enter/Continue を押下後、自動的に選択画面へ戻る。

6. Transaction Code / トランザクションコード

Requirement:

Create a custom T-Code for executing the report.

Example: ZSO_REPORT


レポート実行用に独自トランザクションコードを作成する。

例: ZSO_REPORT


