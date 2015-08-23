"use strict"

class UiStickyController
  constructor: ($scope,$document)->
    UiStickyController.$inject = ["$scope", "$document"];
    this.$document = $document
    this.clickOffsetX = 0
    this.clickOffsetY = 0

class UiSticky

  @getDDO = ()->
    link: UiSticky.postLink
    controller: UiStickyController
    controllerAs: "sticky"
    scope: {}

  @postLink = (scope,element,attr,controller)->
    element.addClass "ui-sticky"

    ###
    Event Functions
    ###

    onMouseDown = (event)->

      controller.element = event.srcElement
      controller.clickOffsetX = event.offsetX
      controller.clickOffsetY = event.offsetY
      element = angular.element event.srcElement
      element.addClass "ui-sticky-grabbing"


    onMouseUp = (event)->
      controller.element = undefined
      controller.clickOffsetX = 0
      controller.clickOffsetY = 0
      element = angular.element event.srcElement
      element.removeClass "ui-sticky-grabbing"

    onMouseMove = (event)->
      if controller.element
        event.stopPropagation()
        event.preventDefault()
        top = event.pageY - controller.clickOffsetY
        left = event.pageX - controller.clickOffsetX
        controller.element.style.top = top + "px"
        controller.element.style.left =  left + "px"

    ###
    Add Listener
    ###
    element.on "mousedown", onMouseDown
    element.on "mouseup", onMouseUp
    angular.element(controller.$document).on "mousemove", onMouseMove

stickyApp = angular.module('sticky',[])
stickyApp.directive "uiSticky", UiSticky.getDDO
