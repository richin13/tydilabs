class AssetCreationManager
  constructor: () ->

  manageAssetType: (typeSelector) ->
    proc = (e) =>
      plate_number_wrapper = $ 'div.asset_plate_number'
      quantity_wrapper = $ 'div.asset_quantity'
      val = this.selected typeSelector
      if val == 'PlatedAsset'
        plate_number_wrapper.removeClass 'hidden'
        quantity_wrapper.addClass 'hidden'
      else
        quantity_wrapper.removeClass 'hidden'
        plate_number_wrapper.addClass 'hidden'
    typeSelector.change(proc)
    proc()

  selected: (typeSelector) -> typeSelector.find('option:selected').val()

class AssetDisplayManager
  constructor: () ->

  initMomentJS: (selector) ->
    date = selector.data('date')
    selector.html(moment(date).fromNow())

  registerModal: (trigger, _modal) ->
    console.log(_modal)
    trigger.on 'click', (e) ->
      e.preventDefault()
      _modal.modal('show')

  registerActions: (selector, modal) ->
    $(selector).on 'click', (e) ->
      e.preventDefault()
      $(modal).modal('show')


$(document).on 'turbolinks:load', () ->
  $('.selectpicker').selectpicker() # Init bootstrap-select

  mgr = new AssetCreationManager()
  mgr.manageAssetType($ '#asset_type')

  displayMgr = new AssetDisplayManager()
  displayMgr.initMomentJS $('.momentjs')

  mappings = [
    ['#a-specs-create',   '#specs-modal-create'],
    ['#di-specs-edit',    '#specs-modal-edit'],
    ['#a-warranty-create','#warranty-modal-create'],
    ['#di-warranty-edit', '#warranty-modal-edit'],
    ['#di-warranty-edit', '#warranty-modal-edit'],
    ['#a-network-create', '#network-modal-create'],
    ['#di-network-edit',  '#network-modal-edit'],
    ['#a-security-create','#security-modal-create'],
    ['#di-security-edit', '#security-modal-edit']
  ]

  for m in mappings
    displayMgr.registerActions(m[0], m[1])


  true

