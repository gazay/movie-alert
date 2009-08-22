jQuery(function($) {
    $('input.default').focus(function() {
        var el = $(this)
        if (el.hasClass('default')) {
            el.data('defaultValue', el.val()).removeClass('default').val('').
                    parents('li').addClass('used')
        }
    }).blur(function() {
        var el = $(this)
        if ('' == el.val()) {
            el.addClass('default').val(el.data('defaultValue')).
                    parents('li').removeClass('used')
        }
    })
    
    $('#filters select[name=genre]').change(function() {
        var el = $(this)
        if (0 == el.attr('selectedIndex')) {
            el.addClass('default').parents('li').removeClass('used')
        } else {
            el.removeClass('default').parents('li').addClass('used')
        }
    })
    
    $('#filters input[name=actor]').autocomplete('/suggest/actor')
    $('#filters input[name=director]').autocomplete('/suggest/actor')
    
    reload_movies = function() {
        $('#movies').addClass('loaded')
        data = {}
        $('#filters input:not(.default),' + 
          ' #filters select:not(.default)').each(function() {
            var el = $(this)
            el.parents('li').addClass('used')
            data[el.attr('name')] = el.val()
        })
        
        $.get('/index.part', data, function(data) {
            $('#movies').empty().removeClass('loaded').append(data)
        }, 'html')
    }
    
    $('#filters select, #filters input').change(function() {
        reload_movies()
    })
})
