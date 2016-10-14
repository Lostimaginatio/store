+function ($) {
    'use strict';

    var grid = '.datagrid';
    var form = '[data-form="gridorder"]';
    var input = '[name="quantity"]';

    var URL_CHECK_ORDER = '/orders/current_order';
    var URL_CREATE_ORDER = '/orders/populate';
    var URL_UPDATE_ORDER = '/orders/update';

    var GridOrder = function()
    {
        $(document).on('change.ss.gridorder', input, this.change());

        this.init();
    };

    GridOrder.prototype.init = function() {
        this.order = this.makeRequest(URL_CHECK_ORDER);
    };

    GridOrder.prototype.change = function() {
        var $this = $(this);
        var $form = $this.parents(form)
    };

    GridOrder.prototype.makeRequest = function(url, data) {
        if (!data) data = null;
        $.ajax({
            url: url,
            type: 'get',
            data: data,
            success: GridOrder.prototype.test
        });
    };

    GridOrder.prototype.test = function(){
        console.log('test');
    };

    $.fn.gridorder = function()
    {
        return this.each(function() {
            var $this = $(this);
            var data = $this.data('ss.gridorder');
            $this.data('ss.gridorder', (data = new GridOrder()))
        });
    };

    $(window).on('load', function(){
        $(grid).gridorder();
    });
}(jQuery);