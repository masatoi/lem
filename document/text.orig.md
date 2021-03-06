# バッファ
{lem:buffer type}
{lem:current-buffer function}
{lem:current-buffer setf}
{lem:make-buffer function}
{lem:bufferp function}
{lem:buffer-modified-p function}
{lem:buffer-enable-undo-p function}
{lem:buffer-enable-undo function}
{lem:buffer-disable-undo function}
{lem:buffer-name function}
{lem:buffer-filename function}
{lem:buffer-directory function}
{lem:buffer-unmark function}
{lem:buffer-rename function}
{lem:buffer-list function}
{lem:get-buffer function}
{lem:delete-buffer function}
{lem:get-next-buffer function}
{lem:get-previous-buffer function}
{lem:bury-buffer function}
{lem:get-file-buffer function}

# ポイント
{lem:point type}
{lem:point-buffer function}
{lem:point-kind function}
{lem:current-point function}
{lem:pointp function}
{lem:copy-point function}
{lem:delete-point function}
{lem:point= function}
{lem:point/= function}
{lem:point< function}
{lem:point<= function}
{lem:point> function}
{lem:point>= function}

{lem:set-current-mark function}

{lem:character-at function}
{lem:line-string function}

{lem:line-number-at-point function}
{lem:point-column function}
{lem:position-at-point function}

{lem:with-point macro}
{lem:save-excursion macro}

## ポイントの取得
{lem:buffer-point function}
{lem:buffer-mark function}
{lem:buffer-start-point function}
{lem:buffer-end-point function}

## ポイント位置の検査
{lem:first-line-p function}
{lem:last-line-p function}
{lem:start-line-p function}
{lem:end-line-p function}
{lem:start-buffer-p function}
{lem:end-buffer-p function}
{lem:same-line-p function}

## ポイントの移動
{lem:move-point function}
{lem:line-start function}
{lem:line-end function}
{lem:buffer-start function}
{lem:buffer-end function}
{lem:line-offset function}
{lem:character-offset function}
{lem:move-to-column function}
{lem:move-to-position function}
{lem:move-to-line function}
{lem:skip-chars-forward function}
{lem:skip-chars-backward function}

## リージョン
{lem:region-beginning function}
{lem:region-end function}
{lem:points-to-string function}
{lem:count-characters function}
{lem:count-lines function}
{lem:apply-region-lines function}

## テキストの編集
{lem:insert-character function}
{lem:insert-string function}
{lem:delete-character function}
{lem:erase-buffer function}
{lem:delete-between-points function}

## テキストプロパティ
{lem:text-property-at function}
{lem:put-text-property function}
{lem:remove-text-property function}
{lem:next-single-property-change function}
{lem:previous-single-property-change function}

## バッファ変数
{lem:buffer-value function}
{lem:buffer-value setf}
{lem:buffer-unbound function}
{lem:clear-buffer-variables function}

# エディタ変数
{lem:editor-variable type}
{lem:define-editor-variable macro}
{lem:clear-editor-local-variables function}
{lem:variable-value function}
{lem:variable-value setf}
