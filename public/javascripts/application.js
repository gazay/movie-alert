jQuery(function($) {
    $('.default').focus(function() {
        var el = $(this)
        if (el.hasClass('default')) {
            el.data('defaultValue', el.val()).removeClass('default').val('')
        }
    }).blur(function() {
        var el = $(this)
        if ('' == el.val()) {
            el.addClass('default').val(el.data('defaultValue'))
        }
    })
})
