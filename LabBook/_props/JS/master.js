$(function () {

    $(document).ready(function () {
        $("#warning").hide();

        var browser = navigator.appName;
        var b_version = navigator.appVersion;
        var version = b_version.split(";");
        if (version[1] != undefined) {
            var trim_Version = version[1].replace(/[ ]/g, "");
            if ((browser == "Microsoft Internet Explorer" && trim_Version == "MSIE7.0") || (browser == "Microsoft Internet Explorer" && trim_Version == "MSIE6.0")) {
                $("#warning").show();
            }
        }
    });
});       
