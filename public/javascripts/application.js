jQuery(function($) {
    $('#filters input').focus(function() {
        $(this).prev().removeClass('clear').addClass('writing').
                attr('title', 'Press Enter to use filter')
    }).blur(function() {
        var el = $(this).prev()
        el.removeClass('writing').attr('title', '')
        if ('' != $(this).val()) {
            el.addClass('clear').attr('title', 'Clear filter')
        }
    }).keydown(function(event) {
        if (13 == event.keyCode) {
            $(this).blur()
            $.address.value(getSearchAddress())
            return false
        }
    })
    
    $('input.default').focus(function() {
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
    
    $('#filters .icon').click(function() {
        var el = $(this)
        if (el.hasClass('clear')) {
            el.next().val('')
            el.removeClass('clear').attr('title', '')
            $.address.value(getSearchAddress())
        }
    })
    
    $('#filters select').change(function() {
        var el = $(this)
        if (0 == el.attr('selectedIndex')) {
            el.addClass('default').parents('li').removeClass('used')
        } else {
            el.removeClass('default').parents('li').addClass('used')
        }
    }).change(function() {
        $.address.value(getSearchAddress())
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
    
    updateFilters = function(data) {
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
        $('#movies ul, .empty').addClass('old')
        $('#logo').addClass('loading')
        
        $.get('/index.part', data, function(content) {
            $('.empty, .next').remove()
            $('#movies').prepend(content)
            $('#logo').removeClass('loading')
            
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
                updateFilters(event.parameters)
                reloadMovies(event.parameters, false)
            }
            first = false
        } else {
            updateFilters(event.parameters)
            reloadMovies(event.parameters, true)
        }
    })
    
    $('.next').show()
    $('#movies .next input').live('click', function() {
        var data = getSearchData()
        $('.next').addClass('loading')
        data['offset'] = $('#movies .next .offset').text()
        $.get('/index.part', data, function(content) {
            $('#movies .next').remove()
            $('#movies').append(content)
            var speed = $('#movies ul:last').height() / 1.6
            $('#movies ul:last').slideDown(speed, function() {
                $('.next').show()
            })
        })
    })
    
    $('#movies li:not(.open)').live('click', function() {
        var el = $(this)
        el.addClass('open').children('.panel').fadeIn(200)
    })
    $('#movies .close, #movies .open .card').live('click', function() {
        $(this).parents('li').children('.panel').fadeOut(200, function() {
            $(this).parents('li').removeClass('open')
        })
        return false
    })
})
