# 吉里吉里Zメニューバーの罠

吉里吉里Z用のメニューバープラグインは，フルスクリーン時の動的消去・表示に対応していないので，自前で制御する必要があります。
メニューバーの機能は過去互換向け・obsolete扱いなので致し方ないところはあるのですが，とりあえず簡易実装のサンプルを作ってみました。

## コード例

例によって Override.tjs などに配置してみてください。
素のKAG3実装を想定しているため，他の拡張との相性問題が発生する可能性があることをご了承くださいませ。

```javascript
// マウス移動時にフックを入れる
function KAGWindow_onMouseMove(x, y, shift) {
	if (isMain && fullScreen) {
		// フルスクリーンで動的メニュー表示対応
		if (y < 4) { // [XXX]どの程度の上部位置でメニューバーを出すか判定（適当に調整のこと）
			if (!menu.visible) menu.visible = true;
		} else {
			if ( menu.visible) menu.visible = false;
		}
	}
	return onMouseMove_orig(...);
}
// メソッド差し替え
&KAGWindow.onMouseMove_orig = &KAGWindow.onMouseMove;
&KAGWindow.onMouseMove = KAGWindow_onMouseMove incontextof null;

// フルスクリーン変更時にフックを入れる
property KAGWindow_fullScreen {
	getter {
		return fullScreen_orig;
	}
	setter(v) {
		var old = fullScreen_orig; // 古いfullScreen状態
		var restore;
		if (isMain) {
			if (v && !old) {
				var iw = innerWidth, ih = innerHeight; // サイズを覚えておく
				// ウィンドウ→フルスクリーンで状態を記録しメニュー表示を消す
				this.__window_restore = [ menu.visible, iw, ih ];
				menu.visible = false;
				setInnerSize(iw, ih); // [XXX] menu.visibleを変更した直後のウィンドウサイズがおかしいので再設定する
			} else if (!v && old) {
				// フルスクリーン→ウィンドウでmenu.visibleを復帰する
				restore = typeof this.__window_restore != "undefined" ? __window_restore : void;
				menu.visible = restore[0] if (restore);
			}
		}
		fullScreen_orig = v; // 更新する
		if (restore) setInnerSize(restore[1], restore[2]); // [XXX]フルスクリーン前のサイズを復帰させる
	}
}

// プロパティ差し替え
&KAGWindow.fullScreen_orig = &KAGWindow.fullScreen;
&KAGWindow.fullScreen = &KAGWindow_fullScreen incontextof null;

// メニューの選択時にフックを入れる
function KAGMenuItem_onClick() {
	var r = onClick_orig();
	// フルスクリーン中であればメニューバーを消す
	if (isvalid this && owner && isvalid owner && typeof owner.isMain != "undefined" && owner.isMain && owner.fullScreen) {
		owner.menu.visible = false;
	}
	return r;
}
// メソッド差し替え
&KAGMenuItem.onClick_orig = &KAGMenuItem.onClick;
&KAGMenuItem.onClick = KAGMenuItem_onClick incontextof null;
```

## 制限など

ゲーム中のコンフィグなどでメニューバー表示ごとON/OFFできる機能がある場合，そちら側の機能と相性が悪い可能性があります。
（フルスクリーン中にコンフィグで変更した場合や，フルスクリーンのままゲームを終了した際にコンフィグの設定との不整合が起こるなど）
あるいは，ウィンドウをリサイズ可能にするプラグインとも相性問題が発生する可能性があります。

またフック処理のために元の関数・プロパティを `～_orig` として保存していますが，この名前がよく使われる可能性があるのため，
他のプラグイン拡張などと名前がバッティングして動作がおかしくなる，といった可能性もあります。（その場合は適宜名前を調整してください…）

その他，マルチモニタ環境においてメニューバーだしたまま別のモニタにマウスカーソルを持ってくと，
メニューバー消えずに表示されたままになる（画面にマウスカーソルを戻すと消える）といった細かい不備があったりしますが，そちらは仕様になります。