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
    
    use_search = function() {
        var data = {}
        $('#filters input:not(.default),' + 
          ' #filters select:not(.default)').each(function() {
            var el = $(this)
            el.parents('li').addClass('used')
            data[el.attr('name')] = el.val()
        })
        $('#dates .used').each(function() {
            var query = $(this).attr('href').substring(2)
            if ('' != query) {
                query = query.split('=')
                data[query[0]] = query[1]
            }
        })
        
        var address = '/?'
        for (key in data) {
            address += encodeURI(key) + '=' + encodeURI(data[key]) + '&'
        }
        $.address.value(address.substring(0, address.length-1))
    }
    
    update_search = function(data) {
        $('#filters .used').removeClass('used')
        for (key in data) {
            if ('year' == key || 'release_date' == key) {
                $('#dates .used').removeClass('used')
                $('a[href="/?' + key + '=' + data[key] + '"]').addClass('used')
            }  else {
                $('#filters [name=' + key + ']').val(data[key]).
                        removeClass('default').parents('li').addClass('used')
            }
        }
        
        reload_movies(data)
    }
    
    reload_movies = function(data) {
        $('#movies').addClass('loaded')
        
        $.get('/index.part', data, function(data) {
            $('#movies').empty().removeClass('loaded').append(data)
        }, 'html')
    }
    
    $('#filters select, #filters input').change(function() {
        use_search()
    })
    
    $('#dates a').click(function() {
        $('#dates .used').removeClass('used')
        $(this).addClass('used')
        use_search()
        return false
    })
    
    $.address.change(function(event) {
        update_search(event.parameters)
    })
})
