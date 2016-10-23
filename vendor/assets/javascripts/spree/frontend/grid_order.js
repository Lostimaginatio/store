+function ($) {
    'use strict';

    var grid = '.datagrid';
    var form = '[data-form="gridorder"]';
    var input = '[name="quantity"]';
    var button = '.quantity-button';
    var cartSelector = '#gridorder-cart';
    var spreeCartId = '#link-to-cart';

    function _success(d) {
        if (d.success === 1) {
            this.items = d.order_items;
            this.order = d.order;
            this.triggerCart();
            this.updateCart();

            if (this.initState) {
                this.updateInputs();
                this.initState = false;
            }
        } else {
            GridOrder.prototype.showError(d.error)
        }
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
        this.initState = true;
        this.items = [];
        this.order = {};
        this.cartShown = false;
        this.$cart = null;
        this.clickTimeout = null;

        this.init();

        $(document).on('change.ss.gridorder', input, $.proxy(this.change, this));
        $(document).on('click.ss.gridorder', form+' '+button, $.proxy(this.click, this));
    };

    GridOrder.prototype.VERSION = '0.0.3';

    GridOrder.prototype.init = function () {
        this.loadItems();
        this.initCart();

        $(form).submit(function(e){
            $(this).find(input).blur();
            e.preventDefault();
        })
    };

    GridOrder.prototype.loadItems = function() {
        this.makeRequest(GET_ORDER_AJAX_SETTINGS);
    };

    GridOrder.prototype.updateInputs = function() {
        var self = this;
        if (this.items.length === 0) return;
        $(form).each(function(){
            var id = $(this).find('[name="variant_id"]').val();
            var itemObj = self.items.find(function(o){return o.variant_id === parseInt(id)});
            if (typeof itemObj == 'object' && itemObj.quantity) $(this).find(input).val(itemObj.quantity);
        });
    };

    GridOrder.prototype.initCart = function()
    {
        var $cart = $('<div>', {
            id: cartSelector.substring(1)
        }).html(
            '<a class="cart-info" href="/cart"><span class="glyphicon glyphicon-shopping-cart">'
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

        var timeout = (settings.url == ADD_ITEM_AJAX_SETTINGS.url) ? 350 : 200;

        if (this.clickTimeout) {
            clearTimeout(this.clickTimeout);
        }

        this.clickTimeout = setTimeout(function(){
            $.ajax({
                url: settings.url,
                type: type,
                data: data,
                context: that,
                success: success
            })
        }, timeout);
    };

    GridOrder.prototype.click = function (event) {
        var $this = $(event.target).closest(button);
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

    GridOrder.prototype.updateCart = function() {
        var $spreeCart = $(spreeCartId);
        var quantity = this.order.item_count || 'пусто';
        var amount = this.order.item_total !== '0.0' ? this.order.item_total : '';
        var currency = amount !== '' ? this.order.currency : '';

        $spreeCart.find('.cart-info').html(
            '<span class="glyphicon glyphicon-shopping-cart"></span>' +
            ' Корзина: ('+quantity+')  <span class="amount">'+amount+' '+currency+'</span></a>'
        ).addClass(function(){
            return quantity == 'пусто' ? 'full' : 'empty';
        }).toggleClass('full empty');
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