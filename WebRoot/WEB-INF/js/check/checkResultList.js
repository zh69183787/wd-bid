var zz = new RegExp(/^\d+(\.\d+)?$/);//校验是否为数字
function check() {//prePrice   finalPrice

    var i = 0;
    var n;
    var zs;
    $("input[id^=prePrice],input[id^=finalPrice]").each(function () {
        var obj = $(this);
        obj.val(obj.val().replace(",", ""));
//        if (obj.val()!=""&&obj.val().match(/^\d+(\.\d+)?$/)) {
//            zs = "NO";
//        }
    });

    if (zs == "NO"){
        alert("请输入正确的金额格式");
        return false;
    }

    $("input[id^=finalPrice]").each(function () {
        if ($(this).val()!=""&&$(this).val().match(/^[1-9]\d*(\.\d+)?$/)) {
            i++;
            n = $(this).attr("id").substring(11, $(this).attr("id").length - 1);
            if ($("input[id^=prePrice]")[n].value == "") {
                alert("请先填写投标价");
                zs = "NO";
            }
        }
    });
    if (zs == "NO")
        return false;
    if (i > 1) {
        alert("中标结果只能填写一个");
        return false;
    } else {
        return true;
    }
}
