"use strict"

class UiStickyController
  constructor: ($scope,$document)->
    UiStickyController.$inject = ["$scope", "$document"];
    this.$document = $document
    this.clickOffsetX = 0
    this.clickOffsetY = 0
    this.handleOffset =
      x: 0
      y: 0

class UiSticky

  @getDDO = ()->
    link: UiSticky.postLink
    controller: UiStickyController
    controllerAs: "sticky"
    scope:
      config: "&stConfig"

  @postLink = (scope,element,attr,controller)->
    config = scope.config() || {}
    controller.onMove = config.onMove

    element.addClass "ui-sticky"
    controller.stickyElement = element
    controller.handle = element[0].querySelector ".ui-sticky-handle"
    if controller.handle
      rect = controller.handle.getBoundingClientRect()
      stickyRect = element[0].getBoundingClientRect()
      controller.handleOffset =
        x: stickyRect.left - rect.left
        y: stickyRect.top - rect.top
    else
      element.addClass "ui-sticky-handle"

    ###
    Event Functions
    ###

    onMouseDown = (event)->
      element = angular.element event.srcElement
      if element.hasClass("ui-sticky-handle")
        controller.element = event.srcElement
        controller.clickOffset =
          x: event.offsetX
          y: event.offsetY
        element.addClass "ui-sticky-grabbing"

    onMouseUp = (event)->
      element = angular.element event.srcElement
      controller.element = undefined
      controller.clickOffset =
        x: 0
        y: 0
      element.removeClass "ui-sticky-grabbing"

    onMouseMove = (event)->
      if controller.element
        param =
          clickOffset: controller.clickOffset
          handleOffset: controller.handleOffset
          unit: "px"

        controller.onMoveStart?(event,param)
        event.stopPropagation()
        event.preventDefault()


        top = event.pageY - param.clickOffset.y + param.handleOffset.y
        left = event.pageX - param.clickOffset.x + param.handleOffset.x

        param.top = top
        param.left = left

        controller.onMove?(event,param)
        controller.stickyElement.css
          top: param.top + param.unit
          left: param.left + param.unit

        controller.onMoveEnd?(event,param)

    ###
    Add Listener
    ###
    element.on "mousedown", onMouseDown
    controller.$document.on "mouseup", onMouseUp
    controller.$document.on "mousemove", onMouseMove

stickyApp = angular.module('uiSticky',[])
stickyApp.directive "uiSticky", UiSticky.getDDO
