{% include "layouts/course_header.volt" %}
<div class="search-bg">
    <div class="search-box">
        <span class="s-bg"></span>
        <form action="{{ url('index/search') }}" name="" method="get">
            <span class="s-c"><input type="text" name="search" id="keyword" placeholder="搜索您需要的"><em class="btn"></em></span>
        </form>
        <p>热门搜索：<a href="{{ url('index/search') }}?search=系统安全">系统安全培训镜像</a>，<a href="{{ url('index/search') }}?search=Web安全">web安全测试系列课程</a></p>
    </div>
</div>
</div>
<div class="course-list">
    <h2><span id="showlist">课程分类</span>
        <span id="menuTab">
				<!--动态获取输出内容 STA-->
				{% for category in top_categories %}
                {% if loop.index == 1 %}
                <span class="on" category="{{category.cate_name}}" cate-id="{{category.id}}">{{ category.cate_name }}</span>
                {% else %}
                <span category="{{category.cate_name}}" cate-id="{{category.id}}">{{ category.cate_name }}</span>
                {% endif %}
                {% elsefor %}
                {% endfor %}
            <!--动态获取输出内容 END-->
			</span>
        <ul class="menu-list" id="menuList" style="display:none;">
            {% for category in categories %}
            <li><a herf="javascript:;" category="{{category.cate_name}}" cate-id="{{category.id}}">{{ category.cate_name }}</a></li>
            {% elsefor %}
            {% endfor %}
        </ul>
    </h2>
    <!--Tab切换内容 START-->
    <div class="content" id="content">
        <!--动态获取输出内容 STA-->
        <ul id="course-content" class="item clearfix" style="display:block;">
            {% for course in page.items %}
            <li class="box-shadow">
                <a href="{{ url('user/course') }}/{{ course.id |e}}" target="_blank">
                    <img src="{{ course.url|e }}"/>
                    <div class="course-intro">
                        <h3>{{ course.name|e }}</h3>
                        <p>{{ course.description|e }}</p>
                    </div>
                </a>
            </li>
            {% elsefor %}
            <?php echo $t->_("common_no_courses"); ?>
            {% endfor %}
        </ul>
        <ul class="item clearfix" style="display:none;">
            {% for course in page.items %}
            <li class="box-shadow">
                <a href="{{ url('user/course') }}/{{ course.id |e}}" target="_blank">
                    <img src="{{ course.url|e }}"/>
                    <div class="course-intro">
                        <h3>{{ course.name|e }}</h3>
                        <p>{{ course.description|e }}</p>
                    </div>
                </a>
            </li>
            {% elsefor %}
            <?php echo $t->_("common_no_courses"); ?>
            {% endfor %}
        </ul>
        <ul class="item clearfix" style="display:none;">
            {% for course in page.items %}
            <li class="box-shadow">
                <a href="{{ url('user/course') }}/{{ course.id |e}}" target="_blank">
                    <img src="{{ course.url|e }}"/>
                    <div class="course-intro">
                        <h3><a href="{{ url('user/course') }}/{{ course.id |e}}">{{ course.name|e }}</a></h3>
                        <p>{{ course.description|e }}</p>
                    </div>
                </a>
            </li>
            {% elsefor %}
            <?php echo $t->_("common_no_courses"); ?>
            {% endfor %}
        </ul>
        <ul class="item clearfix" style="display:none;">
            {% for course in page.items %}
            <li class="box-shadow">
                <a href="{{ url('user/course') }}/{{ course.id |e}}" target="_blank">
                    <img src="{{ course.url|e }}"/>
                    <div class="course-intro">
                        <h3><a href="{{ url('user/course') }}/{{ course.id |e}}">{{ course.name|e }}</a></h3>
                        <p>{{ course.description|e }}</p>
                    </div>
                </a>
            </li>
            {% elsefor %}
            <?php echo $t->_("common_no_courses"); ?>
            {% endfor %}
        </ul>
        <!--动态获取输出内容 END-->
    </div>
    <!--Tab切换内容 END-->
    <div id="cursePage" class="page">
        <a href="" class="pre bg-pre"><</a>
        <a class="curr">1</a>
        <a href="">2</a>
        <a href="">3</a>
        <a href="">4</a>
        <a href="">5</a>
        <a href="">6</a>
        <a href="">7</a>
        <a href="" class="next bg-green">></a>
    </div>
</div>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{% include "layouts/footer.volt" %}
{% include "layouts/common_login.volt" %}
<script>
    var userBox = document.getElementById('uName');
    var userInfo = document.getElementById('userInfo');
    userInfo.onmouseover = function () {
        userInfo.style.display = 'block';
    };
    userBox.onmouseover = function () {
        userInfo.style.display = 'block';
    };
    userInfo.onmouseout = function () {
        userInfo.style.display = 'none';
    };
    userBox.onmouseout = function () {
        userInfo.style.display = 'none';
    };

    var curr_page = 1;	//当前分页
    var total_page = 1;	//分页总数
    var curr_category = "";		//当前课程分类

    $(function(){
        //menuList中下拉菜单的显示和隐藏
        $("#showlist").bind("click", function(){
            if($("#menuList").is(":visible")) {
                $("#menuList").hide();
            } else {
                $("#menuList").show();
            }
        })

        //点击左侧Menu，如果右侧导航没有该菜单，则替换右侧导航的第一；否则显示右侧相应菜单
        $("#menuList").find("a").bind("click", function(){
            var category = $(this).attr("category");
            var cateId = $(this).attr("cate-id");
            if ($("#menuTab span[category=" + category + "]").length > 0) {
                $("#menuTab span[category=" + category + "]").click();
            } else {
                $("#menuTab span[category]:first").text($(this).text());
                $("#menuTab span[category]:first").attr("category", category);
                $("#menuTab span[category]:first").attr("cate-id", cateId);
                $("#menuTab span[category]:first").click();
            }
            $("#menuList a").css("color", "#ffffff");
            $(this).css("color", "red");
            $("#menuList").hide();
        })

        //点击横向导航时，向后台查询数据，并重新渲染课程列表
        $("#menuTab span[category]").bind("click", function(){
            $("#menuTab .on").removeClass("on");
            $(this).addClass("on");
            var category = $(this).attr("cate-id");
            curr_category = category;
            curr_page = 1;
            searchContents(true);
        })

        $("#menuTab span[category]:first").click();
    })

    //查询课程数据 initPage:是否需要初始化分页
    function searchContents(initPage) {
        $.ajax({
            type: "get",
            url: '{{url("index/coursesJSON")}}',
            data: {
                cur_page: curr_page,
                category: curr_category,
                search: $("#keyword").val()
            },
            success: function(data){
                data = $.parseJSON(data);
                var contents = data.page.items;
                var totalPages = data.page.total_pages;
                initCategoryContent(contents);
                total_page = totalPages;
                if (initPage) {
                    if (totalPages <= 1) {
                        $("#cursePage").hide();
                    } else {
                        $("#cursePage").empty();
                        var pageHtml = "";
                        pageHtml += '<a href="javascript:;" class="pre bg-pre"><</a>';
                        for (var i = 1; i <= totalPages; i++) {
                            if (i == 1) {
                                pageHtml += '<a class="curr">1</a>';
                            } else {
                                pageHtml += '<a class="page-num" pageNum="' + i + '" href="javascript:;">' + i + '</a>';
                            }
                        }
                        pageHtml += '<a href="javascript:;" class="next bg-green">></a>';
                        $("#cursePage").html(pageHtml);
                        $("#cursePage").show();

                        $("#cursePage a").bind("click", function(){
                            //上一页
                            if ($(this).attr("class").indexOf("pre") > -1) {
                                if (curr_page == 1) return false;
                                curr_page -= 1;
                            } else if ($(this).attr("class").indexOf("next") > -1) {	//下一页
                                if (curr_page == total_page) return false;
                                curr_page += 1;
                            } else {
                                var pageNum = $(this).text();
                                curr_page = pageNum;
                                if (curr_page == 1) {   // 当前为第一页， 上一页不可点击
                                    $("#cursePage a.pre").removeClass("bg-green").addClass("bg-pre");
                                } else if (curr_page == total_page) {   // 当前为最后一页，下一页不可点击
                                    $("#cursePage a.next").removeClass("bg-green").addClass("bg-pre");
                                }  else {
                                    $("#cursePage a.bg-pre").removeClass("bg-pre").addClass("bg-green");
                                }
                            }
                            $("#cursePage").find(".curr").removeClass("curr");
                            $("#cursePage a[pageNum=" + curr_page + "]").addClass("curr");
                            searchContents(false);
                        });
                    }
                }
            },
            error: function(e) {
                console.log(e)
            }
        });
    }

    // 渲染课程列表
    function initCategoryContent(contents) {
//        $("#content").empty();
        $('#course-content').children().filter('li').remove();
        var html = "";
        for (var i = 0; i < contents.length; i++) {
            var msg = '<li class="box-shadow">'
                    + '	<a href="{{url("user/course")}}/' + contents[i].id + '" target="_blank">'
                    + '		<img src="' + contents[i].url + '"/>'
                    + '		<div class="course-intro">'
                    + '			<h3>' + contents[i].name + '</h3>'
                    + '			<p>' + contents[i].description + '</p>'
                    + '		</div>'
                    + '	</a>'
                    + '</li>';
            $('#course-content').append(msg);
        }
//        $("#content").html(html);
    }
</script>