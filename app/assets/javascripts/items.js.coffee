$ ->
  $(document).on 'keyup', 'form.item-form #item_body', ->
    $previewArea = $(@).closest('form').find('.preview.panel-default .panel-body')

    $.post '/items/preview', md_body: $(@).val(), (html_text) ->
      $previewArea.html(html_text)

