{% include "layouts/course_header.volt" %}
<div class="search-bg">
    <div class="search-box">
        <span class="s-bg"></span>
        <form action="" name="" method="get">
            <span class="s-c"><input type="text" name="search" id="keyword" placeholder="搜索您需要的"><em class="btn"></em></span>
        </form>
        <p>热门搜索：<a href="{{ url('index/search') }}?search=系统安全">系统安全培训镜像</a>，<a href="{{ url('index/search') }}?search=Web安全">web安全测试系列课程</a></p>
    </div>
</div>
</div>
<div class="course-list">
    <br>
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
        <!--动态获取输出内容 END-->
    </div>
    <!--Tab切换内容 END-->
    <div class="page">
        <a href="{{ url('index/courses') }}/<?= $page->before; ?>" class="pre bg-green"><</a>
        <?php for($item = 1; $item <= $page->total_pages; $item++){
        if ($item == $page->current){
        echo '<span class="curr">'.$item.'</span>';
        } else {
        echo '<span><a href="courses/'.$item.'" class="item bg-green">'.$item.'</a></span>';
        }
        }
        ?>
        <a href="{{ url('index/courses') }}/<?= $page->next; ?>" class="next bg-green">></a>
    </div>
</div>
{{ javascript_include("assets/bower/jquery/dist/jquery.min.js") }}
{{ javascript_include("js/common.js") }}
{% include "layouts/footer.volt" %}