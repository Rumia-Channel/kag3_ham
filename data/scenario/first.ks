﻿;===============================================================================
; 最初に読み込まれるシナリオファイル
;===============================================================================

[wait time=200]

;===============================================================================
; この辺りにマクロ定義を記述すると良いでしょう
; ユーザー定義マクロは冷凍鱧より下にお書きください
;;===============================================================================
; 冷凍鱧 定義
;;===============================================================================
;;===============================================================================
;; ゲーム用にメッセージウィンドウを最適化します。
;[macro name="meswininit_g"]
;[position layer="message0" visible="false"]
;[position layer="message1" top="560" height="144" visible="true"]
;[position layer="message2" top="540" left="40" height="32" width="192" visible="true" margint="1" marginb="1" marginl="1" marginr="1" opacity="0"]
;[layopt layer="message2" index="1999000"]
;[current layer="message1"]
;[endmacro]
;;===============================================================================
;; システム用にテキストレイヤーを最適化します。
;[macro name="meswininit_i"]
;[position layer="message1" visible="false"]
;[position layer="message0" visible="true"]
;[position layer="message2" visible="false"]
;[current layer="message0"]
;[endmacro]
;;===============================================================================
;; 名前を表示します
;; 引数
;; ・hist  noを書くとログに表示されなくなります。
;; 　・途中で名前を変えたり不明から名前に変更する場合に重宝します
;; ・type　事実上必須です。(つけない場合は色は黒になります)
;; 　・main：主人公達です。, mobm：モブキャラ(男)です。, mobf：モブキャラ(女)です。
;; 　・モブキャラで中性の設定はありません(今後追加予定)
;; 　・cust：カスタムカラー 使用する場合は color 引数を使い色を指定してください。
;; ・charname　必須です。見たままキャラクター名(表示名)を入力します。
;; 名前を消したい場合は erdn (次に定義しています)をご利用ください。
;[macro name="disname"]
;[current layer="message2"]
;[er]
;[if exp="mp.hist=='no'"]
;[history output="false"]
;[endif]
;[font size="24"]
;[if exp="mp.type=='main'"]
;[font color="0xFFDD00"]
;[elsif exp="mp.type=='mobm'"]
;[font color="0x7F40FF"]
;[elsif exp="mp.type=='mobf'"]
;[font color="0xFF407F"]
;[elsif exp="mp.type=='cust'"]
;[font color="mp.color"]
;[else]
;[font color="0x000000"]
;[endif]
;[nowait]
;[emb exp="mp.charname"]
;[endnowait][resetfont]
;[if exp="mp.hist=='no'"]
;[history output="true"]
;[endif]
;[current layer="message1"]
;[endmacro]
;;===============================================================================
;; 名前を表示を消します。
;[macro name="erdn"]
;[current layer="message2"]
;[er]
;[current layer="message1"]
;[endmacro]
;;===============================================================================
;; 章タイトルをメッセージウィンドウに出力します。
;; 引数
;; ・ctitle　主題です。
;; ・csubtitle　副題です。サブタイトルですが字幕ではありません。
;[macro name="sectitle"]
;[font size="48" bold="true" italic="true" shadow="true" shadowcolor="0x191919"][style align="center"]
;[emb exp="mp.ctitle"][wait time="1000"][emb exp="mp.csubtitle"]
;[endmacro]
;;===============================================================================
;; クリックを待ってメッセージウィンドウを消します。
;; 説明
;; ・p タグと er タグの複合です。それ以外のどれでもありません。
;; ・メッセージウィンドウからメッセージが消えますが、ログからは消えません。
;[macro name="per"]
;[p][er]
;[endmacro]
;;===============================================================================
;;===============================================================================
;; 冷凍鱧 定義ここまで
;===============================================================================
;外部スクリプトとマクロ
;===============================================================================
;===============================================================================
@iscript
  Scripts.execStorage("macro/MoveMouseCursorPlugin.tjs");
@endscript
[call storage="macro/TJSFunctions.ks"]
[call storage="macro/KLayers.ks"]
[call storage=macro/NameWindowPlugin.ks]
[call storage="macro/Macro_CharLayers.ks"]
[call storage="macro/AltEnterFullScreen.ks"]
[call storage="macro/YesNoDialogLayer.ks"]
[call storage="macro/SelectPlugin.ks"]
[call storage="macro/WindowResizable.ks"]
;===============================================================================
;===============================================================================
; 外部スクリプトとマクロここまで
;===============================================================================
; この辺からユーザー定義
;===============================================================================
;===============================================================================
;[call storage="macro/BHMMacros.ks"]
;===============================================================================
;===============================================================================
; マクロ定義ここまで
;===============================================================================

; タイトル画面のサンプルシナリオへ
[jump storage="title.ks"]
