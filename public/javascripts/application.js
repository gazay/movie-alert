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
    $('#filters input[name=director]').autocomplete('/suggest/director')
    
    getSearch = function() {
        var data = {}
        $('#filters .filter:not(.default)').each(function() {
            var el = $(this)
            el.parents('li').addClass('used')
            if ('' != el.val()) {
                data[el.attr('name')] = el.val()
            }
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
        return address.substring(0, address.length-1)
    }
    
    updateSearch = function(data, animation) {
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
    }
    
    reloadMovies = function(data, animation) {
        $('#movies ul').addClass('old').css('background', 'white')
        
        $.get('/index.part', data, function(data) {
            $('#movies').prepend(data)
            
            if (animation) {
                speed = $('#movies ul:not(.old)').height() / 1.6
                
                $('#movies ul:not(.old)').slideDown(speed)
                $('#movies ul.old').slideUp(speed, function() {
                    $('#movies .old').remove()
                })
            } else {
                $('#movies .old').remove()
                $('#movies ul').show()
            }
            
            if (0 != $('#header .filter:not(.default)').length) {
                $('#subscriptions').show()
                $('#description').hide()
            } else {
                $('#subscriptions').hide()
                $('#description').show()
            }
        }, 'html')
    }
    
    $('#filters select, #filters input').change(function() {
        $.address.value(getSearch())
    })
    
    $('#dates a').click(function() {
        $('#dates .used').removeClass('used')
        $(this).addClass('used')
        $.address.value(getSearch())
        return false
    })
    
    var first = true
    $.address.change(function(event) {
        if (first) {
            if (0 != event.parameterNames.length) {
                updateSearch(event.parameters)
                reloadMovies(event.parameters, false)
            }
            first = false
        } else {
            updateSearch(event.parameters)
            reloadMovies(event.parameters, true)
        }
    })
})
