# uiSticky
付箋的なもの

* jQueryは使ってません

#Code

```html
<div ui-stikcy st-config="config">
  <i class="ui-sticky-handle"></i>
  <p>
    write some thing
  </p>
</div>
```
* `ui-sticky`
 * この属性を指定した要素は自由にDnDできるようになります。また、`.ui-sticky`が自動的に設定されます。
* `.ui-sticky-handle`
 * このクラスを指定した場合は`ui-sticky`をDnDするときにこの要素をDnDする必要があります。指定されていない場合は`ui-sticky`要素に`.ui-sticky-handle`が自動的に設定されます。

#API
##CallBacks
###onMove(event,param)
####Example
```coffee
"use strict"

class HelloController
  constructor: ()->
    this.sticky =
      config:
        onMove: this.onMove

  onMove: (event,param)->
    param.left = 100

helloApp = angular.module('hello',["uiSticky"])
helloApp.controller "HelloController", HelloController
```
```jade
  div(ng-app="hello" ng-controller="HelloController as hello")
    div(ui-sticky="hello.sticky.config")
      p(class="ui-sticky-handle")
```
####Parameters
* `event`: mousemove eventオブジェクトです
* `param`: uiStickyが利用するパラメータが格納されています。
 * `clickOffset`: クリックされた座標が格納されています。
    * `x`: クリックされた要素の左上からの`x`座標です。
    * `y`: クリックされた要素の左上からの`y`座標です。
 * `handleOffset`: `ui-sticky-handle`が`ui-sticky`要素のどこに存在するかが格納されています。
    * `x`: `ui-sticky`要素の左上からの`x`座標です。
    * `y`: `ui-sticky`要素の左上からの`y`座標です。
 * `top`  : 要素の縦位置において、どこに移動しようとしているかが格納されています。
 * `left` : 要素の横位置において、どこに移動しようとしているかが格納されています。
