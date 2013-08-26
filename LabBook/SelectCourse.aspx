<%@ Page Title="" Language="C#" MasterPageFile="~/LabBook.Master" AutoEventWireup="true"
    CodeBehind="SelectCourse.aspx.cs" Inherits="LabBook.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实验预约</title>
    <link href="_props/CSS/SelectCourse.css" rel="Stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ExperimentSort fix">
        <label class="sort">
            实验分类</label>
        <form action="" class="Select">
        <select name="experiment" class="experiment" >
            <%foreach (var exp in ExperimentList)
              {%>
            <option value="<%=exp.Id%>">
                <%=exp.Name%></option>
            <%} %>
        </select>
        </form>
    </div>
    <h2 class="ListHead">
        实验列表</h2>
    <table class="ExperimentTable" id="course-list">
        <thead>
            <tr class="table-head">
                <th class="Title">
                    实验
                </th>
                <th>
                    指导老师
                </th>
                <th>
                    实验地点
                </th>
                <th>
                    预约
                </th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="ajax_div1">
        <img src="_props/images/ajax_loader.gif" alt="正在加载..." title="正在加载..." /><span>正在加载数据...</span>
    </div>
    <h2 class="ListHead">
        实验包列表</h2>
    <table class="ExperimentPackageTable" id="package-list">
        <thead>
            <tr class="table-head">
                <th class="Title">
                    实验
                </th>
                <th>
                    指导老师
                </th>
                <th>
                    实验地点
                </th>
                <th>
                    预约
                </th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div id="ajax_div2">
        <img src="_props/images/ajax_loader.gif" alt="正在加载..." title="正在加载..." /><span>正在加载数据...</span>
    </div>
    <script type="text/javascript">
        $(function () {
            //alert($.qurey.get('id'));
            var expId = $.query.get("id");
            if (expId == "") {
                expId = $(".experiment").val();
            }
            $.get("RefreshCourseTable.ashx", { key: expId }, refresh_course, 'json');
            $.get("RefreshPackageTable.ashx", { exp: expId }, refresh_package, 'json');
            $(".experiment").change(function () {
                $("#ajax_div1").show();
                $("#ajax_div2").show();
                var val = $(this).val();
                $("#course-list thead").siblings().children().remove();
                $("#package-list thead").siblings().children().remove();
                $.get("RefreshCourseTable.ashx", { key: val }, refresh_course, 'json');
                $.get("RefreshPackageTable.ashx", { exp: val }, refresh_package, 'json');
            });

            function refresh_course(data) {
                $("#ajax_div1").hide();
                //alert(data);
                var tr, td;
                for (var i = 0; i < data.length; i++) {
                    tr = $('<tr></tr>');
                    for (var key in data[i]) {
                        if (key == 'Id')
                            td = $('<td><a href="BookCourse.aspx?id=' + data[i][key] + '">预约</a></td>');
                        else
                            td = $('<td>' + data[i][key] + '</td>');
                        td.appendTo(tr).hide().fadeIn(400);
                    }
                    // td = $('<td><a href="BookCourse.aspx">预约</a></td>');
                    // td.appendTo(tr);
                    //var xx = tr > td.last.val();
                    //alert(xx);
                    $("#course-list tbody").append(tr);
                }

            }

            function refresh_package(data) {
                $("#ajax_div2").hide();
                //alert(data);
                //$(".table-head").siblings().remove()
                var tr, td;
                for (var i = 0; i < data.length; i++) {
                    tr = $('<tr></tr>');
                    for (var key in data[i]) {
                        if (key == 'Id')
                            td = $('<td><a href="BookPackage.aspx?id=' + data[i][key] + '">预约</a></td>');
                        else
                            td = $('<td>' + data[i][key] + '</td>');
                        td.appendTo(tr).hide().fadeIn(400);
                    }
                    //td = $('<td><a href="BookCourse.aspx">预约</a></td>');
                    //td.appendTo(tr);
                    $("#package-list").append(tr);
                }
            }

        });

    </script>
    <%--引用的有关url操作的函数--%>
    <script type="text/javascript">
        new function (settings) {
            // Various Settings
            var $separator = settings.separator || '&';
            var $spaces = settings.spaces === false ? false : true;
            var $suffix = settings.suffix === false ? '' : '[]';
            var $prefix = settings.prefix === false ? false : true;
            var $hash = $prefix ? settings.hash === true ? "#" : "?" : "";
            var $numbers = settings.numbers === false ? false : true;

            jQuery.query = new function () {
                var is = function (o, t) {
                    return o != undefined && o !== null && (!!t ? o.constructor == t : true);
                };
                var parse = function (path) {
                    var m, rx = /\[([^[]*)\]/g, match = /^([^[]+)(\[.*\])?$/.exec(path), base = match[1], tokens = [];
                    while (m = rx.exec(match[2])) tokens.push(m[1]);
                    return [base, tokens];
                };
                var set = function (target, tokens, value) {
                    var o, token = tokens.shift();
                    if (typeof target != 'object') target = null;
                    if (token === "") {
                        if (!target) target = [];
                        if (is(target, Array)) {
                            target.push(tokens.length == 0 ? value : set(null, tokens.slice(0), value));
                        } else if (is(target, Object)) {
                            var i = 0;
                            while (target[i++] != null);
                            target[--i] = tokens.length == 0 ? value : set(target[i], tokens.slice(0), value);
                        } else {
                            target = [];
                            target.push(tokens.length == 0 ? value : set(null, tokens.slice(0), value));
                        }
                    } else if (token && token.match(/^\s*[0-9]+\s*$/)) {
                        var index = parseInt(token, 10);
                        if (!target) target = [];
                        target[index] = tokens.length == 0 ? value : set(target[index], tokens.slice(0), value);
                    } else if (token) {
                        var index = token.replace(/^\s*|\s*$/g, "");
                        if (!target) target = {};
                        if (is(target, Array)) {
                            var temp = {};
                            for (var i = 0; i < target.length; ++i) {
                                temp[i] = target[i];
                            }
                            target = temp;
                        }
                        target[index] = tokens.length == 0 ? value : set(target[index], tokens.slice(0), value);
                    } else {
                        return value;
                    }
                    return target;
                };

                var queryObject = function (a) {
                    var self = this;
                    self.keys = {};

                    if (a.queryObject) {
                        jQuery.each(a.get(), function (key, val) {
                            self.SET(key, val);
                        });
                    } else {
                        jQuery.each(arguments, function () {
                            var q = "" + this;
                            q = q.replace(/^[?#]/, ''); // remove any leading ? || #
                            q = q.replace(/[;&]$/, ''); // remove any trailing & || ;
                            if ($spaces) q = q.replace(/[+]/g, ' '); // replace +'s with spaces

                            jQuery.each(q.split(/[&;]/), function () {
                                var key = decodeURIComponent(this.split('=')[0] || "");
                                var val = decodeURIComponent(this.split('=')[1] || "");

                                if (!key) return;

                                if ($numbers) {
                                    if (/^[+-]?[0-9]+\.[0-9]*$/.test(val)) // simple float regex
                                        val = parseFloat(val);
                                    else if (/^[+-]?[0-9]+$/.test(val)) // simple int regex
                                        val = parseInt(val, 10);
                                }

                                val = (!val && val !== 0) ? true : val;

                                if (val !== false && val !== true && typeof val != 'number')
                                    val = val;

                                self.SET(key, val);
                            });
                        });
                    }
                    return self;
                };

                queryObject.prototype = {
                    queryObject: true,
                    has: function (key, type) {
                        var value = this.get(key);
                        return is(value, type);
                    },
                    GET: function (key) {
                        if (!is(key)) return this.keys;
                        var parsed = parse(key), base = parsed[0], tokens = parsed[1];
                        var target = this.keys[base];
                        while (target != null && tokens.length != 0) {
                            target = target[tokens.shift()];
                        }
                        return typeof target == 'number' ? target : target || "";
                    },
                    get: function (key) {
                        var target = this.GET(key);
                        if (is(target, Object))
                            return jQuery.extend(true, {}, target);
                        else if (is(target, Array))
                            return target.slice(0);
                        return target;
                    },
                    SET: function (key, val) {
                        var value = !is(val) ? null : val;
                        var parsed = parse(key), base = parsed[0], tokens = parsed[1];
                        var target = this.keys[base];
                        this.keys[base] = set(target, tokens.slice(0), value);
                        return this;
                    },
                    set: function (key, val) {
                        return this.copy().SET(key, val);
                    },
                    REMOVE: function (key) {
                        return this.SET(key, null).COMPACT();
                    },
                    remove: function (key) {
                        return this.copy().REMOVE(key);
                    },
                    EMPTY: function () {
                        var self = this;
                        jQuery.each(self.keys, function (key, value) {
                            delete self.keys[key];
                        });
                        return self;
                    },
                    load: function (url) {
                        var hash = url.replace(/^.*?[#](.+?)(?:\?.+)?$/, "$1");
                        var search = url.replace(/^.*?[?](.+?)(?:#.+)?$/, "$1");
                        return new queryObject(url.length == search.length ? '' : search, url.length == hash.length ? '' : hash);
                    },
                    empty: function () {
                        return this.copy().EMPTY();
                    },
                    copy: function () {
                        return new queryObject(this);
                    },
                    COMPACT: function () {
                        function build(orig) {
                            var obj = typeof orig == "object" ? is(orig, Array) ? [] : {} : orig;
                            if (typeof orig == 'object') {
                                function add(o, key, value) {
                                    if (is(o, Array))
                                        o.push(value);
                                    else
                                        o[key] = value;
                                }
                                jQuery.each(orig, function (key, value) {
                                    if (!is(value)) return true;
                                    add(obj, key, build(value));
                                });
                            }
                            return obj;
                        }
                        this.keys = build(this.keys);
                        return this;
                    },
                    compact: function () {
                        return this.copy().COMPACT();
                    },
                    toString: function () {
                        var i = 0, queryString = [], chunks = [], self = this;
                        var encode = function (str) {
                            str = str + "";
                            if ($spaces) str = str.replace(/ /g, "+");
                            return encodeURIComponent(str);
                        };
                        var addFields = function (arr, key, value) {
                            if (!is(value) || value === false) return;
                            var o = [encode(key)];
                            if (value !== true) {
                                o.push("=");
                                o.push(encode(value));
                            }
                            arr.push(o.join(""));
                        };
                        var build = function (obj, base) {
                            var newKey = function (key) {
                                return !base || base == "" ? [key].join("") : [base, "[", key, "]"].join("");
                            };
                            jQuery.each(obj, function (key, value) {
                                if (typeof value == 'object')
                                    build(value, newKey(key));
                                else
                                    addFields(chunks, newKey(key), value);
                            });
                        };

                        build(this.keys);

                        if (chunks.length > 0) queryString.push($hash);
                        queryString.push(chunks.join($separator));

                        return queryString.join("");
                    }
                };

                return new queryObject(location.search, location.hash);
            };
        } (jQuery.query || {}); 
    </script>
</asp:Content>
