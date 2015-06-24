(function ($) {

    $.fn.extend({
        wrapCheckboxGroup: function (settings) {
            _loadData( $(this),settings,_wrapCheckboxGroup);
        }
    })

    $.fn.extend({
        wrapSelect: function (settings) {
            var $target = $(this);

            $target.prepend("<select name='"+settings.name  +"'><option value=''>请选择</option></select>");
            $("select[name='"+settings.name+"']").addClass("input_xxlarge");
            _loadData($("select[name='"+settings.name+"']"),settings,_wrapSelect);

        }
    });


    function _loadData(target, settings,callback) {
        $.ajax({
            url:settings.url,
            data:settings.param,
            dataType :"json",
            success:function (data) {
                callback(target, data, settings);
            }
        });
    }

    function _wrapCheckboxGroup(target, json, settings) {
        settings = $.extend({defaultLabel: "请选择", defaultValue: "", label: "dictName", value: "dictName", root: "dictionaries", selectVal: ""}, settings);
        var list = getJsonValByProperty(json, settings.root) || [];
        var html = '';
        $.each(list, function (i, o) {
            var label = getJsonValByProperty(o, settings.label);
            var value = getJsonValByProperty(o, settings.value);

            html += '<input type="checkbox" value="'+value+'" name="'+settings.name+'"/><span style="display: inline;margin-right:10px">'+label+'</span>';
        });

        target.html(html);
        $(target).find(":checkbox").filter(function(index) {
            return settings.selectVal.indexOf($(this).val()) != -1;
        }).prop("checked",true);
    }

    function _wrapSelect(target, json, settings) {

        settings = $.extend({defaultLabel: "请选择", defaultValue: "", label: "dictName", value: "dictName", root: "dictionaries", selectVal: ""}, settings);

        var list = getJsonValByProperty(json, settings.root) || [];
        target.find("option").remove();
        var html = '<option value=' + settings.defaultValue + '>' + settings.defaultLabel + '</option>';
        $.each(list, function (i, o) {
            var label = getJsonValByProperty(o, settings.label);
            var value = getJsonValByProperty(o, settings.value);

            html += '<option value="' + value + '">' + label + '</option>';
        });


        target.html(html);
        target.find("option[value=" + settings.selectVal + "]").attr("selected", "selected");

        if(settings.selectVal != ""){

            $("#"+settings.name).val(target.find("option[value=" + settings.selectVal + "]").text());
            $("#"+settings.name+"Id").val(target.find("option[value=" + settings.selectVal + "]").val());
        }
        target.trigger("completed");

    }
obj.a
    var a = {"root":{"obj":{"a":"1"}}};
    function getJsonValByProperty(json, prop) {
        if (prop.indexOf(".") != -1) {
            var props = prop.split(".");
            for (var i = 0; i < props.length; i++) {
                json = getJsonValByProperty(json, props[i]);
            }
            return json;
        } else {
            for (var key in json) {
                if (key == prop)
                    return json[key];
            }
        }
    }

})(jQuery);