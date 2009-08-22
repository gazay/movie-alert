jQuery(function($) {
    $('input.default').focus(function() {
        var el = $(this)
        if (el.hasClass('default')) {
            el.data('defaultValue', el.val()).removeClass('default').val('')
//                    parents('li').addClass('used')
        }
    }).blur(function() {
        var el = $(this)
        if ('' == el.val()) {
            el.addClass('default').val(el.data('defaultValue'))
//                    parents('li').removeClass('used')
        }
    })
    
    $('#movie_genre').change(function() {
        var el = $(this)
        if (0 == el.attr('selectedIndex')) {
            el.addClass('default').parents('li').removeClass('used')
        } else {
            el.removeClass('default').parents('li').addClass('used')
        }
    })
    
    // $('#subscriptions :submit').attr('disabled', 'disabled')
    // $('#subscriptions :text').keyup(function() {
    //   var el = $(this)
    //   if ('' != el.val()) {
    //     $('#subscriptions :submit').attr('disabled', '')
    //   } else if (0 != $('#subscriptions .default').length) {
    //     $('#subscriptions :submit').attr('disabled', 'disabled')
    //   }
    // })
    
    $('#filters input[name=actor]').autocomplete('/suggest/actor')
    $('#filters input[name=director]').autocomplete('/suggest/actor')
})
