+function ($) {
    'use strict';

    var grid = '.datagrid';
    var form = '[data-form="gridorder"]';
    var input = '[name="quantity"]';
    var button = '.quantity-button';
    var cartSelector = '#gridorder-cart';

    function _success(d) {
        if (d.success === 1) {
            this.items = d.order_items;
            this.order = d.order;
            this.triggerCart();
        } else {
            GridOrder.prototype.showError(d.error)
        }
    }

    function _getScrollbarWidth() {
        var outer = document.createElement("div");
        outer.style.visibility = "hidden";
        outer.style.width = "100px";
        outer.style.msOverflowStyle = "scrollbar"; // needed for WinJS apps

        document.body.appendChild(outer);

        var widthNoScroll = outer.offsetWidth;
        // force scrollbars
        outer.style.overflow = "scroll";

        // add innerdiv
        var inner = document.createElement("div");
        inner.style.width = "100%";
        outer.appendChild(inner);

        var widthWithScroll = inner.offsetWidth;

        // remove divs
        outer.parentNode.removeChild(outer);

        return widthNoScroll - widthWithScroll;
    }

    var GET_ORDER_AJAX_SETTINGS = {
        url: '/ajax/order_items'
    };
    var ADD_ITEM_AJAX_SETTINGS = {
        url: '/ajax/add_item'
    };
    var UPDATE_ITEM_AJAX_SETTINGS = {
        url: '/ajax/update_item'
    };

    var GridOrder = function()
    {
        this.items = [];
        this.order = {};
        this.cartShown = false;
        this.$cart = null;
        this.scrollbarWidth = _getScrollbarWidth();

        this.init();

        $(document).on('change.ss.gridorder', input, $.proxy(this.change, this));
        $(document).on('click.ss.gridorder', form+' '+button, $.proxy(this.click, this));
    };

    GridOrder.prototype.VERSION = '0.0.1';

    GridOrder.prototype.init = function () {
        this.loadItems();
        this.initCart();
        this.updateInputs();
    };

    GridOrder.prototype.loadItems = function() {
        this.makeRequest(GET_ORDER_AJAX_SETTINGS);
    };

    GridOrder.prototype.updateInputs = function() {

    };

    GridOrder.prototype.initCart = function()
    {
        var $cart = $('<div>', {
            id: cartSelector.substring(1)
        }).html(
            '<a class="cart-info full" href="/cart"><span class="glyphicon glyphicon-shopping-cart">'
        );

        $('body').append($cart);
        this.$cart = $cart;
    };

    GridOrder.prototype.change = function(event) {
        var $input = $(event.target);
        var $form = $input.parents(form);
        var formData = $form.serializeArray();
        var variantId = formData.find(function(o){return o.name === 'variant_id'}).value;
        var quantity = formData.find(function(o){return o.name === 'quantity'}).value;

        if (quantity < 0) {
            quantity = 0;
            $input.val(0);
        }

        var lineItem = this.items.find(function(o){return o.variant_id === parseInt(variantId)});

        if (lineItem !== undefined) {
            this.makeRequest(UPDATE_ITEM_AJAX_SETTINGS, {
                order: {line_items_attributes: [{id: lineItem.id, quantity: quantity}]}
            });
        } else {
            if (quantity == 0) return;
            this.makeRequest(ADD_ITEM_AJAX_SETTINGS, {variant_id: variantId, quantity: quantity});
        }
    };

    GridOrder.prototype.makeRequest = function(settings, data) {
        var that = this;
        var type = settings.type || 'post';
        var success = settings.success || _success;
        data = data || null;
        $.ajax({
            url: settings.url,
            type: type,
            data: data,
            context: that,
            success: success
        });
    };

    GridOrder.prototype.click = function (event) {
        var $this = $(event.target);
        var $input = $this.siblings(input);
        var method = $this.data('gridorder-method');
        $input.val(function(i, v){
            if(method == 'minus'){v--}else{v++}
            return v;
        }).trigger('change.ss.gridorder')
    };

    GridOrder.prototype.triggerCart = function() {
        var quantity = this.order.item_count || 0;

        if (!this.cartShown && quantity > 0) {
            this.$cart.animate({right: -1}, 300);
            this.cartShown = true;
        } else if (this.cartShown && quantity == 0) {
            this.$cart.animate({right: -this.$cart.outerWidth()}, 300);
            this.cartShown = false;
        }
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