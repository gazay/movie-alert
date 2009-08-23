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
    
    getSearchData = function() {
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
        return data
    }
    
    getSearchAddress = function() {
        var data = getSearchData()
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
        
        $.get('/index.part', data, function(content) {
            $('.empty, .next, .next_offset').remove()
            $('#movies').prepend(content)
            
            if (animation) {
                var speed = $('#movies ul:not(.old)').height() / 1.6
                
                $('#movies ul:not(.old)').slideDown(speed, function() {
                    $('.next').show()
                })
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
        $.address.value(getSearchAddress())
    })
    
    $('#dates a').click(function() {
        $('#dates .used').removeClass('used')
        $(this).addClass('used')
        $.address.value(getSearchAddress())
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
    
    $('.next').show()
    $('#movies .next').live('click', function() {
        var data = getSearchData()
        data['offset'] = $('#movies .next_offset').text()
        $.get('/index.part', data, function(content) {
            $('#movies .next, #movies .next_offset').remove()
            $('#movies').append(content)
            var speed = $('#movies ul:last').height() / 1.6
            $('#movies ul:last').slideDown(speed, function() {
                $('.next').show()
            })
        })
    })
    
    $('#movies li').live('click', function() {
        var el = $(this).toggleClass('open')
        if (el.hasClass('open')) {
            el.animate({paddingRight: '1em'}, 100, function() {
                el.animate({paddingRight: '16em'}, 500)
                el.children('.info').animate({width: 'show'}, 500)
            })
        } else {
            el.animate({paddingRight: '0.5em'}, 500)
            el.children('.info').animate({width: 'hide'}, 500)
        }
    })
})
