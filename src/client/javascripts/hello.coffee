"use strict"

class HelloController
  constructor: ($scope,$document)->
    HelloController.$inject = ["$scope", "$document"];
    this.$document = $document
    this.sticky =
      config:
        onMove: this.onMove

  onMove: (event,param)->
    param.left = 100


helloApp = angular.module('hello',["uiSticky"])
helloApp.controller "HelloController", HelloController
